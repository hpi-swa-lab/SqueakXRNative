import java.io.FileInputStream
import java.util.Properties

val devPropertiesFile = rootProject.file("dev.properties")
val devProperties = Properties()
devProperties.load(FileInputStream(devPropertiesFile))

plugins {
    alias(libs.plugins.android.application)
    alias(libs.plugins.kotlin.android)
}

android {
    namespace = "com.swalab.squeakxrnative"
    compileSdk = 35

    defaultConfig {
        applicationId = "com.swalab.squeakxrnative"
        minSdk = 32
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        externalNativeBuild {
            cmake {
                cppFlags += "-std=c++17"
                arguments += "-DLOCAL_RLOPENXR_SOURCE=" + (devProperties["rlOpenXRRepo"] ?: "OFF")
                arguments += "-DLOCAL_OPENSMALLTALKVM_SOURCE=" + (devProperties["opensmalltalkvmRepo"] ?: "OFF")
            }
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    kotlinOptions {
        jvmTarget = "11"
    }
    externalNativeBuild {
        cmake {
            path = file("src/main/cpp/CMakeLists.txt")
            version = "3.22.1"
        }
    }
    buildFeatures {
        viewBinding = true
    }
    ndkVersion = "27.1.12297006"
}

tasks.preBuild {
    exec {
        commandLine("../run-setup.sh")
    }
}

dependencies {

    implementation(libs.androidx.core.ktx)
    implementation(libs.androidx.appcompat)
    implementation(libs.material)
    implementation(libs.androidx.constraintlayout)
    testImplementation(libs.junit)
    androidTestImplementation(libs.androidx.junit)
    androidTestImplementation(libs.androidx.espresso.core)
    implementation(libs.androidx.preference.ktx)


//    implementation(":raymob")
}