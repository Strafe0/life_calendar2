plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.vgol.life_calendar2"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.vgol.life_calendar2"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("com.yandex.android:mobileads-mediation:7.15.2.0")
}

repositories {
    // IronSource
    maven {
        url = uri("https://android-sdk.is.com/")
    }

    // Pangle
    maven {
        url = uri("https://artifact.bytedance.com/repository/pangle")
    }

    // Tapjoy
    maven {
        url = uri("https://sdk.tapjoy.com/")
    }

    // Mintegral
    maven {
        url = uri("https://dl-maven-android.mintegral.com/repository/mbridge_android_sdk_oversea")
    }

    // Chartboost
    maven {
        url = uri("https://cboost.jfrog.io/artifactory/chartboost-ads/")
    }

    // AppNext
    maven {
        url = uri("https://dl.appnext.com/")
    }
}