<#import "./shared_macros.ftl" as shared>
<#import "root://activities/common/kotlin_macros.ftl" as kt>
<#if isLibraryProject>
apply plugin: 'com.android.library'
<#elseif isDynamicFeature>
apply plugin: 'com.android.dynamic-feature'
<#else>
apply plugin: 'com.android.application'
</#if>
<@kt.addKotlinPlugins />
apply from: "${androidModuleCommon}"
apply from: "${rootDir}/build_common.gradle"

<@shared.androidConfig hasApplicationId=isApplicationProject applicationId=packageName hasTests=true canHaveCpp=true canUseProguard=isApplicationProject||isLibraryProject />

dependencies {
    <@kt.addKotlinDependencies />

    implementation deps.ycdev.androidBase
    implementation deps.ycdev.androidUi

    implementation deps.androidx.coreKtx
    implementation deps.androidx.appcompat
    implementation deps.androidx.material
    implementation deps.androidx.constraintLayout
    implementation deps.androidx.recyclerview
    implementation deps.navigation.uiKtx
    implementation deps.navigation.fragmentKtx
    implementation deps.lifecycle.runtime
    implementation deps.lifecycle.extensions
    implementation deps.lifecycle.viewModelKtx
    implementation deps.lifecycle.liveDataKtx
    implementation deps.gson
    implementation deps.timber

    // Dependencies for local unit tests
    testImplementation deps.test.core
    testImplementation deps.test.junit
    testImplementation deps.test.truth
    testImplementation deps.test.mockk
    testImplementation deps.ycdev.androidTest

    // Android Testing Support Library's runner and rules
    androidTestImplementation deps.test.runner
    androidTestImplementation deps.test.rules

<#if isDynamicFeature>
  implementation project(':${baseFeatureName}')
<#elseif (WearprojectName?has_content) && (Mobileincluded!false) && (Wearincluded!false)>
  wearApp project(':${WearprojectName}')
</#if>
}
