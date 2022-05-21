import 'package:custom_social_share/src/enums.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'custom_social_share_method_channel.dart';

abstract class CustomSocialSharePlatform extends PlatformInterface {
  /// Constructs a CustomSocialSharePlatform.
  CustomSocialSharePlatform() : super(token: _token);

  static final Object _token = Object();

  static CustomSocialSharePlatform _instance = MethodChannelCustomSocialShare();

  /// The default instance of [CustomSocialSharePlatform] to use.
  ///
  /// Defaults to [MethodChannelCustomSocialShare].
  static CustomSocialSharePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CustomSocialSharePlatform] when
  /// they register themselves.
  static set instance(CustomSocialSharePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// copy text [content] to clipboard
  Future<bool> copy(String content) {
    throw UnimplementedError('copy() has not been implemented.');
  }

  /// open system UI to share text [content]
  Future<bool> toAll(String content) {
    throw UnimplementedError('toAll() has not been implemented.');
  }

  /// share text [content] with social apps
  /// [shareWith] is [ShareWith] different type of default apps
  Future<bool> to(ShareWith shareWith, String content) {
    throw UnimplementedError('to() has not been implemented.');
  }

  /// return list of default [ShareWith] installed apps
  Future<List<ShareWith>> getInstalledAppsForShare() {
    throw UnimplementedError(
        'getInstalledAppsForShare() has not been implemented.');
  }

  /// custom app share only for Android
  /// [package] is android application id
  /// text [content] to share
  Future<bool> customApp(String package, String content) {
    throw UnimplementedError('customApp() has not been implemented.');
  }
}
