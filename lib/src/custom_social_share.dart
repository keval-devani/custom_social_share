import 'package:custom_social_share/src/enums.dart';

import 'custom_social_share_platform_interface.dart';

/// CustomSocialShare to copy content to clipboard and share text
class CustomSocialShare {
  /// copy text [content] to clipboard
  Future<void> copy(String content) {
    return CustomSocialSharePlatform.instance.copy(content);
  }

  /// open system UI to share text [content]
  Future<bool> toAll(String content) {
    return CustomSocialSharePlatform.instance.toAll(content);
  }

  /// share text [content] with social apps
  /// [shareWith] is [ShareWith] different type of default apps
  Future<bool> to(ShareWith shareWith, String content) {
    return CustomSocialSharePlatform.instance.to(shareWith, content);
  }

  /// return list of default [ShareWith] installed apps
  Future<Map<String, bool>> getInstalledAppsForShare() async {
    return CustomSocialSharePlatform.instance.getInstalledAppsForShare();
  }

  /// custom app share only for Android
  /// [package] is android application id
  /// text [content] to share
  Future<bool> customApp(String package, String content) {
    return CustomSocialSharePlatform.instance.customApp(package, content);
  }
}
