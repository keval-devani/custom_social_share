import 'package:custom_social_share/src/custom_social_share.dart';
import 'package:custom_social_share/src/custom_social_share_method_channel.dart';
import 'package:custom_social_share/src/custom_social_share_platform_interface.dart';
import 'package:custom_social_share/src/enums.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCustomSocialSharePlatform
    with MockPlatformInterfaceMixin
    implements CustomSocialSharePlatform {
  @override
  Future<bool> copy(String content) => Future.value(content == 'success');

  @override
  Future<bool> toAll(String content) => Future.value(content == 'success');

  @override
  Future<bool> to(ShareWith shareWith, String content) =>
      Future.value(ShareWith.sms == shareWith && content == 'success');

  @override
  Future<List<ShareWith>> getInstalledAppsForShare() =>
      Future.value([ShareWith.sms, ShareWith.email]);

  @override
  Future<bool> customApp(String package, String content) => Future.value(
      package == 'com.google.android.apps.dynamite' && content == 'success');
}

void main() {
  final CustomSocialSharePlatform initialPlatform =
      CustomSocialSharePlatform.instance;

  test('$MethodChannelCustomSocialShare is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCustomSocialShare>());
  });

  test('getPlatformVersion', () async {
    CustomSocialShare customSocialSharePlugin = CustomSocialShare();
    MockCustomSocialSharePlatform fakePlatform =
        MockCustomSocialSharePlatform();
    CustomSocialSharePlatform.instance = fakePlatform;

    expect(await customSocialSharePlugin.toAll('success'), true);
    expect(await customSocialSharePlugin.toAll('other'), false);

    expect(await customSocialSharePlugin.to(ShareWith.sms, 'success'), true);
    expect(await customSocialSharePlugin.to(ShareWith.email, 'other'), false);

    expect(await customSocialSharePlugin.getInstalledAppsForShare(),
        [ShareWith.sms, ShareWith.email]);

    expect(
        await customSocialSharePlugin.customApp(
            'com.google.android.apps.dynamite', 'success'),
        true);
    expect(
        await customSocialSharePlugin.customApp('com.google.android', 'other'),
        false);
  });
}
