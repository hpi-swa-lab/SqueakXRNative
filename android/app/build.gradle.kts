import java.util.Properties

plugins {
    alias(libs.plugins.android.application)
    alias(libs.plugins.kotlin.android)
}

// Each entry is a repository whose assets/ folder ends up at xr-assets/<repository name>/ in the APK.
// Additional repositories (comma-separated, relative to the SqueakXRNative checkout) can be set via
// squeakxr.assetRepositories in local.properties or gradle.properties; missing ones are skipped.
val squeakXRRoot = rootDir.parentFile
val localProperties = Properties().apply {
    rootDir.resolve("local.properties").takeIf { it.isFile }?.reader()?.use { load(it) }
}
val configuredAssetRepositories = localProperties.getProperty("squeakxr.assetRepositories")
    ?: providers.gradleProperty("squeakxr.assetRepositories").orNull
    ?: "../SqueakXR-Games"
val assetRepositories: List<File> = listOf(squeakXRRoot) +
    configuredAssetRepositories
        .split(',').map { it.trim() }.filter { it.isNotEmpty() }
        .map { squeakXRRoot.resolve(it).canonicalFile }
        .filter { repository ->
            repository.resolve("assets").isDirectory.also { present ->
                if (!present) logger.warn("SqueakXR: no assets found in ${repository.path}, skipping")
            }
        }
val stagedAssetsDir = layout.buildDirectory.dir("generated/xrAssets")

val stageXRAssets by tasks.registering(Sync::class) {
    into(stagedAssetsDir.map { it.dir("xr-assets") })
    assetRepositories.forEach { repository ->
        from(repository.resolve("assets")) {
            into(repository.name)
            exclude("**/*.exr", "**/*.blend", "**/*.usdc", "**/*.tres", "**/*_TONEMAPPED.jpg", "**/*.py", "**/.DS_Store")
        }
    }
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
        ndk {
            abiFilters += "arm64-v8a"
        }
        externalNativeBuild {
            cmake {
                cppFlags += "-std=c++17"
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
    sourceSets["main"].assets.srcDir(stagedAssetsDir)
    ndkVersion = "27.1.12297006"
}

dependencies {

    implementation(libs.androidx.core.ktx)
    implementation(libs.androidx.appcompat)
    implementation(libs.material)
    implementation(libs.androidx.constraintlayout)
    implementation(libs.androidx.activity)
    testImplementation(libs.junit)
    androidTestImplementation(libs.androidx.junit)
    androidTestImplementation(libs.androidx.espresso.core)
    implementation(libs.androidx.preference.ktx)


//    implementation(":raymob")
}

tasks.matching { it.name.startsWith("merge") && it.name.endsWith("Assets") }.configureEach {
    dependsOn(stageXRAssets)
}