<?xml version="1.0"?>
<recipe>
    <instantiate from="root/build.gradle.ftl"
                   to="${escapeXmlAttribute(topOut)}/build.gradle" />

<#if makeIgnore>
    <copy from="root/project_ignore"
            to="${escapeXmlAttribute(topOut)}/.gitignore" />
</#if>

    <instantiate from="root/settings.gradle.ftl"
                   to="${escapeXmlAttribute(topOut)}/settings.gradle" />

    <instantiate from="root/gradle.properties.ftl"
                   to="${escapeXmlAttribute(topOut)}/gradle.properties" />

    <copy from="../../gradle/wrapper"
        to="${escapeXmlAttribute(topOut)}/" />

<#if hasSdkDir>
    <instantiate from="root/local.properties.ftl"
                   to="${escapeXmlAttribute(topOut)}/local.properties" />
</#if>

    <copy from="root/ndroid_project_common.gradle"
        to="${escapeXmlAttribute(topOut)}/ndroid_project_common.gradle" />
    <copy from="root/android_module_common.gradle"
        to="${escapeXmlAttribute(topOut)}/android_module_common.gradle" />
    <copy from="root/aosp.keystore"
        to="${escapeXmlAttribute(topOut)}/aosp.keystore" />
    <copy from="root/build_common.gradle"
        to="${escapeXmlAttribute(topOut)}/build_common.gradle" />
</recipe>
