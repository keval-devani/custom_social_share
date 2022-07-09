# custom_social_share

Flutter plugin for sharing text content to most popular social media apps.

You can use it to copy to clipboard, share with WhatsApp, Facebook, Messenger, Instagram, Reddit, Skype, Snapchat, Telegram,
Twitter and other social media apps and also with System Share UI.

**Note: This plugin is still under development, and some APIs might not be available yet. Feedback and Pull Requests are most
welcome!**

## Getting Started

add `custom_social_share` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

Please use the latest version of package

```
dependencies:
  ...
  
  custom_social_share: ^latest_version
```

## Setup

### Android

There is nothing to set up in android.

### iOS

Make sure you add below value in url scheme in your plist file

```
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>fb</string>
    <string>fb-messenger</string>
    <string>instagram</string>
    <string>line</string>
    <string>linkedin</string>
    <string>reddit</string>
    <string>skype</string>
    <string>slack</string>
    <string>snapchat</string>
    <string>tg</string>
    <string>twitter</string>
    <string>viber</string>
    <string>weixin</string>
    <string>whatsapp</string>
</array>
```

If you are planning use only WhatsApp, then only add whatsapp url scheme and same for other apps also.

````
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>whatsapp</string>
</array>
````

## Usage

#### Add the following imports to your Dart code:

```
import 'package:custom_social_share/custom_social_share.dart';
```

## Methods

### Copy to clipboard

```
CustomSocialShare().copy("Hii from new plugin https://www.google.com with link");
```

### Open system share UI

```
CustomSocialShare().toAll("Hii from new plugin https://www.google.com with link");
```

### Get installed social apps for share

```
var List<ShareWith> = await CustomSocialShare().getInstalledAppsForShare();
```

### To social apps

```
// to sms
CustomSocialShare().to(ShareWith.sms, "Hii from new plugin https://www.google.com with link");

// to email
CustomSocialShare().to(ShareWith.email, "Hii from new plugin https://www.google.com with link");

// to WhatsApp
CustomSocialShare().to(ShareWith.whatsapp, "Hii from new plugin https://www.google.com with link");
```

### To custom app (Android Only)

```
// to custom app package
CustomSocialShare().customApp('com.google.android.apps.dynamite', "Hii from new plugin https://www.google.com with link");
```

These methods will return ```true``` if they successfully open to the corresponding app otherwise ```false```.