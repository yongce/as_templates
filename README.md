# ide_as

This repo is for things related to Android Studio (such as the templates for Android Studio).

## Templates

There are a lot of templates of projects, modules and others in Android Studio.
The templates are located in the installation folder of Android Studio.
For example, the templates folder is at
/Applications/Android Studio.app/Contents/plugins/android/lib/templates in Mac OS.

If we want to create our own templates or modify the existing templates,
we have to change the contents of Android Studio's templates folder.
But the folder is part of Android Studio installation files,
the changes may be lost caused by Android Studio's upgrade/reinstall activities.
Also, the templates may be updated by Android Studio new versions.
You should always maintain your templates based on the latest Android Studio Official versions.

So, we should keep tracking of the AOSP templates versions (upstream versions)
and maintain the difference between our versions and the upstream versions.

### How to get AOSP templates

The Android Studio templates folder is located at platform/tools/base/templates in AOSP code.
The repo path is "platform/tools/base" and you should use the "studio-master-dev" branch.

The repo size of "platform/tools/base" is super huge. It will be a long time to clone the whole repo.
You can use the following command to clone the latest commit only:

```shell
git clone --single-branch --branch studio-master-dev --depth 1 https://android.googlesource.com/platform/tools/base aosp_tools_base
```

### How does this repo work

There are two branches in this repo. One is "master" and other one is "upstream".

The upstream branch will keep the commits in AOSP.
Every commit in upstream branch has commit details (such as SHA1) of the AOSP commit.

The master branch will merge the latest commits in upstream branch and then create/modify the tempaltes.
