// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://docs.flutter.dev/cookbook/testing/integration/introduction

import 'package:custom_social_share/custom_social_share.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('toAll test', (WidgetTester tester) async {
    final CustomSocialShare plugin = CustomSocialShare();
    final bool result = await plugin.toAll('Test');
    expect(result, true);
  });
}
