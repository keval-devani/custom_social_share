import 'package:custom_social_share/src/enums.dart';

import 'custom_social_share_platform_interface.dart';

class CustomSocialShare {
  Future<bool> copy(String content) {
    return CustomSocialSharePlatform.instance.copy(content);
  }

  Future<bool> toAll(String content) {
    return CustomSocialSharePlatform.instance.toAll(content);
  }

  Future<bool> to(ShareWith shareWith, String content) {
    return CustomSocialSharePlatform.instance.to(shareWith, content);
  }

  Future<List<ShareWith>> getInstalledAppsForShare() async {
    return CustomSocialSharePlatform.instance.getInstalledAppsForShare();
  }

  Future<bool> customApp(String package, String content) {
    return CustomSocialSharePlatform.instance.customApp(package, content);
  }
}
