import 'package:custom_social_share/src/custom_social_share_method_channel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  MethodChannelCustomSocialShare platform = MethodChannelCustomSocialShare();
  const MethodChannel channel = MethodChannel('custom_social_share');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return true;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('copy', () async {
    expect(await platform.copy('success'), true);
  });
}
