import java.security.KeyStore
import java.security.MessageDigest
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val releaseKeyProperties = Properties()
val releaseKeyPropertiesFile = rootProject.file("key.properties")
if (releaseKeyPropertiesFile.isFile) {
    releaseKeyPropertiesFile.inputStream().use { releaseKeyProperties.load(it) }
}

// Certificate of the original Smart Memory APKs. Updates must retain this identity.
val originalSigningCertificateSha256 =
    "697978d4e52d391b3de08de7a78ed340c92e96fb45e3bb99b6bb4fa4417f8b31"

android {
    namespace = "com.mkce.smartmemory"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.mkce.smartmemory"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 24
        targetSdk = 36
        multiDexEnabled = true
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            releaseKeyProperties.getProperty("storeFile")?.let {
                storeFile = rootProject.file(it)
            }
            storePassword = releaseKeyProperties.getProperty("storePassword")
            keyAlias = releaseKeyProperties.getProperty("keyAlias")
            keyPassword = releaseKeyProperties.getProperty("keyPassword")
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

val validateReleaseSigning = tasks.register("validateReleaseSigning") {
    group = "verification"
    description = "Check that release updates use the original Smart Memory signing key."
    doLast {
        val help = "See android/RELEASE_SIGNING.md. Do not uninstall the existing app."
        if (!releaseKeyPropertiesFile.isFile) {
            throw GradleException("Release signing requires android/key.properties and the ORIGINAL signing key. $help")
        }
        fun requiredProperty(name: String): String =
            releaseKeyProperties.getProperty(name)?.takeIf { it.isNotBlank() }
                ?: throw GradleException("Missing release signing property: $name. $help")

        val keyFile = rootProject.file(requiredProperty("storeFile"))
        if (!keyFile.isFile) {
            throw GradleException("The configured release keystore does not exist. $help")
        }
        val storePassword = requiredProperty("storePassword").toCharArray()
        val keyPassword = requiredProperty("keyPassword").toCharArray()
        try {
            val keyStore = KeyStore.getInstance(keyFile, storePassword)
            val alias = requiredProperty("keyAlias")
            if (!keyStore.isKeyEntry(alias) || keyStore.getKey(alias, keyPassword) == null) {
                throw GradleException("The configured alias does not contain a signing private key. $help")
            }
            val certificate = keyStore.getCertificate(alias)
                ?: throw GradleException("No signing certificate exists for the configured alias. $help")
            val fingerprint = MessageDigest.getInstance("SHA-256")
                .digest(certificate.encoded).joinToString("") { "%02x".format(it) }
            if (fingerprint != originalSigningCertificateSha256) {
                throw GradleException("Signing key mismatch: this key cannot update the original Smart Memory app. $help")
            }
            logger.lifecycle("Release signing certificate matches the original Smart Memory APKs.")
        } finally {
            storePassword.fill('\u0000')
            keyPassword.fill('\u0000')
        }
    }
}

tasks.matching { it.name == "preReleaseBuild" }.configureEach {
    dependsOn(validateReleaseSigning)
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

flutter {
    source = "../.."
}
