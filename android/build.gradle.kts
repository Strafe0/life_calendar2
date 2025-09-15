allprojects {
    repositories {
        google()
        mavenCentral()

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
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
