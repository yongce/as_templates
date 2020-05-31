buildscript {
    ext {
        androidProjectCommon = "${rootDir}/android_project_common.gradle"
        androidModuleCommon = "${rootDir}/android_module_common.gradle"
    }
    apply from: "${androidProjectCommon}"

    repositories {
        google()
        jcenter()
        <#if includeKotlinEapRepo!false>maven { url '${kotlinEapRepoUrl}' }</#if>
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:${gradlePluginVersion}'
        <#if generateKotlin>classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:${versions.kotlin}"</#if>
    }
}

// Add plugin for 'spotless'
plugins {
    id "com.diffplug.gradle.spotless" version "3.27.1"
}

allprojects {
    repositories {
        google()
        jcenter()
        <#if includeKotlinEapRepo!false>maven { url '${kotlinEapRepoUrl}' }</#if>
    }
}

task clean(type: Delete) {
    delete rootProject.buildDir
}

spotless {
<#if generateKotlin>
    kotlin {
        target "**/*.kt"
        ktlint(versions.ktlint)
    }
</#if>
}

ext {
    versions.ndkVersion = "21.0.6113669"
}
