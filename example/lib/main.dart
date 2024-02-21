import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:snapchat_loginkit/snapchat_loginkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> implements LoginStateCallback {
  String _platformVersion = 'Unknown';
  String _loginResult = "";
  late final SnapchatLoginkit _snapchatLoginkitPlugin;
  UserDataResponse userDataResponse = UserDataResponse();

  bool isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _snapchatLoginkitPlugin = SnapchatLoginkit(loginStateCallback: this);
    _snapchatLoginkitPlugin.addLoginStateCallback();
    checkUserIsLoggedIn();
    initPlatformState();
  }

  checkUserIsLoggedIn() async {
    isUserLoggedIn = await _snapchatLoginkitPlugin.isUserLoggedIn();
    if (isUserLoggedIn) {
      await fetchUserData();
      setState(() {});
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _snapchatLoginkitPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: isUserLoggedIn
              ? userprofileWidget()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Running on: $_platformVersion\n'),
                    Text('Snapchat Login: $_loginResult'),
                    ElevatedButton(
                      onPressed: () {
                        _snapchatLoginkitPlugin.login();
                      },
                      child: const Text('Login with Snapchat'),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
        ),
      ),
    );
  }

  Widget userprofileWidget() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 50, // Image radius
            backgroundImage: NetworkImage('${userDataResponse.userData?.bitmoji}'),
          ),
          const SizedBox(height: 16),
          Text('${userDataResponse.userData?.displayName}'),
          const SizedBox(height: 16),
          Text('${userDataResponse.userData?.externalId}'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _snapchatLoginkitPlugin.logout();
              setState(() {
                isUserLoggedIn = false;
              });
            },
            child: const Text('Logout'),
          ),
        ],
      );

  @override
  void onFailure(String message) {
    debugPrint("Failure calling...");
  }

  @override
  void onLogout() {
    debugPrint("Logout calling...");
  }

  @override
  void onStart() {
    // TODO: implement onStart
  }

  fetchUserData() async {
    UserDataQuery query =
        UserDataQueryBuilder().withDisplayName().withBitmojiAvatarUrl().withExternalId().build();
    userDataResponse = await _snapchatLoginkitPlugin.fetchUserData(query);
  }

  @override
  void onSuccess(String accessToken) async {
    await fetchUserData();
    setState(() {
      isUserLoggedIn = true;
    });
  }
}
