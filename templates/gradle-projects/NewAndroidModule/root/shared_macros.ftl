<#import "root://gradle-projects/common/proguard_macros.ftl" as proguard>

<#-- Some common elements used in multiple files -->

<#macro generateManifest packageName hasApplicationBlock=false>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
        package="${packageName}"<#if !hasApplicationBlock>/</#if>><#if hasApplicationBlock>

    <application
        android:allowBackup="true"
        android:label="@string/app_name"
        android:icon="@mipmap/ic_launcher"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/AppTheme" />
</manifest></#if>
</#macro>

<#macro androidConfig hasApplicationId=false applicationId='' hasTests=false canHaveCpp=false canUseProguard=false>
android {
    compileSdkVersion <#if buildApiString?matches("^\\d+$")>${buildApiString}<#else>'${buildApiString}'</#if>
    <#if explicitBuildToolsVersion!false>buildToolsVersion "${buildToolsVersion}"</#if>

    defaultConfig {
    <#if hasApplicationId>
        applicationId "${applicationId}"
        targetSdkVersion <#if targetApiString?matches("^\\d+$")>${targetApiString}<#else>'${targetApiString}'</#if>
    </#if>
        minSdkVersion versions.minSdk

    <#if hasApplicationId>
        versionName getAppVersionNameBase() // + build type suffix
        versionCode getAppVersionCodeBase() * 10000 + calculatedVersionCode
    </#if>

    <#if hasTests>
        testInstrumentationRunner "${getMaterialComponentName('android.support.test.runner.AndroidJUnitRunner', useAndroidX)}"
    </#if>
    <#if canUseProguard && (isLibraryProject!false)>
        consumerProguardFiles 'consumer-rules.pro'
    </#if>
    <#if canHaveCpp && (includeCppSupport!false)>

        externalNativeBuild {
            cmake {
                cppFlags "${cppFlags}"
            }
        }
    </#if>
    }

<#if hasApplicationId>
    buildFeatures {
        viewBinding = true
    }

    buildTypes {
        debug {
            versionNameSuffix "-debug"
        }

        release {
            versionNameSuffix "-" + calculatedVersionCode + buildIdSuffix

            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
<#else>
<@proguard.proguardConfig />
</#if>

<#if canHaveCpp && (includeCppSupport!false)>
    externalNativeBuild {
        cmake {
            path "src/main/cpp/CMakeLists.txt"
            version "3.10.2"
        }
    }
</#if>

    lintOptions {
        textReport true
        textOutput 'stdout'

        // disable category "Accessibility"
        disable 'ClickableViewAccessibility','ContentDescription','LabelFor'
        disable 'GoogleAppIndexingWarning'
    }
}
</#macro>
