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
  UserResponse userResponse = UserResponse();

  bool isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _snapchatLoginkitPlugin = SnapchatLoginkit(loginStateCallback: this);
    _snapchatLoginkitPlugin.addLoginStateCallback();
    checkUserIsLoggedIn();
    initPlatformState();
    hasAccessToScope();
    fetchAccessToken();
  }

  checkUserIsLoggedIn() async {
    isUserLoggedIn = await _snapchatLoginkitPlugin.isUserLoggedIn();
    if (isUserLoggedIn) {
      await fetchUserData();
      setState(() {});
    }
  }

  fetchAccessToken() async {
    final response = await _snapchatLoginkitPlugin.fetchAccessToken();
    debugPrint("Token Code: ${response.code}");
    debugPrint("Token Message: ${response.message}");
    debugPrint("Token Token: ${response.token}");
  }

  hasAccessToScope() async {
    final bool hasAccess = await _snapchatLoginkitPlugin
        .hasAccessToScope('https://auth.snapchat.com/oauth2/api/user.display_name');
    debugPrint("hasAccess: $hasAccess");
  }

  loginWithFirebase() async {
    final TokenResponse tokenResponse = await _snapchatLoginkitPlugin.loginWithFirebase();
    debugPrint("FirebaseTokenGrant: ${tokenResponse.token}");
    // Here you should be good to authenticate with Firebase
    // using "signInWithCustomToken()" API
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
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          _snapchatLoginkitPlugin.login();
                        },
                        child: const Text('Login with Snapchat'),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
        ),
      ),
    );
  }

  Widget userprofileWidget() => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 50, // Image radius
                backgroundImage: NetworkImage('${userResponse.user?.avatarUrl}'),
              ),
              const SizedBox(height: 16),
              Text('Display Name: ${userResponse.user?.displayName}'),
              const SizedBox(height: 16),
              Text('External ID: ${userResponse.user?.externalId}'),
              const SizedBox(height: 16),
              Text('Avatar ID: ${userResponse.user?.avatarId}'),
              const SizedBox(height: 16),
              Text('Token ID: ${userResponse.user?.tokenId}'),
              const SizedBox(height: 16),
              Text('Profile Link: ${userResponse.user?.profileLink}'),
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
              const SizedBox(height: 16),
              Text('Result: ${userResponse.code}: ${userResponse.message}'),
              const SizedBox(height: 32),
            ],
          ),
        ),
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
    UserDataQuery query = UserDataQueryBuilder()
        .withDisplayName()
        .withBitmojiAvatarId()
        .withBitmojiAvatarUrl()
        .withExternalId()
        .withIdToken()
        .withProfileLink()
        .build();
    userResponse = await _snapchatLoginkitPlugin.fetchUserData(query);
    debugPrint("User Code: ${userResponse.code}");
    debugPrint("User Message: ${userResponse.message}");
    debugPrint("User: ${userResponse.user}");
  }

  @override
  void onSuccess(String accessToken) async {
    await fetchUserData();
    setState(() {
      isUserLoggedIn = true;
    });
  }
}
