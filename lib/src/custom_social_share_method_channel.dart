import 'dart:io';

import 'package:custom_social_share/src/enums.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'custom_social_share_platform_interface.dart';

/// An implementation of [CustomSocialSharePlatform] that uses method channels.
class MethodChannelCustomSocialShare extends CustomSocialSharePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('custom_social_share');

  @override
  Future<void> copy(String content) {
    return Clipboard.setData(ClipboardData(text: content));
  }

  @override
  Future<bool> toAll(String content) {
    return methodChannel.invokeMethod<bool>('toAll',
        {"content": content}).then<bool>((bool? value) => value ?? false);
  }

  @override
  Future<bool> to(ShareWith shareWith, String content) {
    return methodChannel.invokeMethod<bool>(shareWith.name,
        {"content": content}).then<bool>((bool? value) => value ?? false);
  }

  @override
  Future<Map<String, bool>> getInstalledAppsForShare() {
    return methodChannel
        .invokeMapMethod<String, bool>('getInstalledApps')
        .then((map) {
      if (map == null) return {};
      return map;
    });
  }

  @override
  Future<bool> customApp(String package, String content) {
    if (!Platform.isAndroid) return Future.value(false);
    return methodChannel.invokeMethod<bool>('customApp', {
      "package": package,
      "content": content
    }).then<bool>((bool? value) => value ?? false);
  }
}
