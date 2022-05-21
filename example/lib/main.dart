import 'package:custom_social_share/custom_social_share.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _share = CustomSocialShare();

  final _msg = 'Hii from new plugin https://www.google.com with link';
  var _onlyInstalled = false;
  var _installedApps = <ShareWith>[];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(colorScheme: const ColorScheme.light(), useMaterial3: true),
      darkTheme: ThemeData.from(colorScheme: const ColorScheme.dark(), useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Social Share'),
        ),
        body: Column(
          children: [
            SwitchListTile.adaptive(
              title: const Text('Only installed app'),
              value: _onlyInstalled,
              onChanged: (bool value) {
                _onlyInstalled = value;
                setState(() {});

                if (value) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    _share.getInstalledAppsForShare().then((value) {
                      debugPrint("_MyAppState.build: $value");
                      _installedApps = value;
                      setState(() {});
                    });
                  });
                }
              },
              secondary: const Icon(Icons.install_mobile),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: IntrinsicWidth(
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          child: const Text('Copy'),
                          onPressed: () {
                            _share.copy(_msg).then((value) => debugPrint("_MyAppState.build: $value"));
                          },
                        ),
                        ElevatedButton(
                          child: const Text('All'),
                          onPressed: () {
                            _share.toAll(_msg).then((value) => debugPrint("_MyAppState.build: $value"));
                          },
                        ),
                        ElevatedButton(
                          child: const Text('Custom App'),
                          onPressed: () {
                            _share
                                .customApp('com.google.android.apps.dynamite', _msg)
                                .then((value) => debugPrint("_MyAppState.build: $value"));
                          },
                        ),
                        for (var item in (_onlyInstalled ? _installedApps : ShareWith.values))
                          ElevatedButton(
                            child: Text(item.value),
                            onPressed: () {
                              _share.to(item, _msg).then((value) => debugPrint("_MyAppState.build: $value"));
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
