# snapchat_loginkit
[![pub package](https://img.shields.io/pub/v/snapchat_loginkit.svg)](https://pub.dev/packages/snapchat_loginkit)
[![license](https://img.shields.io/badge/license-MIT-green)](https://github.com/DevCrew-io/snapchat_loginkit/blob/main/LICENSE)
![](https://img.shields.io/badge/Code-Dart-informational?style=flat&logo=dart&color=29B1EE)
![](https://img.shields.io/badge/Code-Flutter-informational?style=flat&logo=flutter&color=0C459C)

A Flutter plugin for integrating Snapchat login kit into your Flutter applications, allowing users to log in with their Snapchat accounts.

## Features
- **Snapchat login:** Enable users to log in to your app using their Snapchat credentials.
- **User Information Retrieval**: After Successful login, Get the user information such as displayName, AvatarUrl, AvatarId, externalId, tokenId and profileLink.
- **Check To User Logged In**: Check if the user is already logged in to Snapchat.
- **Fetch Access Token**: Retrieve the access token after a successful login, which can be used to make API calls to Snapchat on behalf of the user.
- **Access To Scope**: Check if the user has granted access to a specific scope (permission) in their Snapchat account.
- **Login With Firebase**: Integrate Firebase authentication with Snapchat login, allowing users to log in to your app using Firebase authentication after logging in with Snapchat.

![Alt text](https://github.com/DevCrew-io/snapchat_loginkit/blob/documentation/assets/example.gif)

## Getting Started
First thing first, you must login to your developer account on [Snapchat Developers portal](https://developers.snap.com/) and get your **Client ID** for the app. For more information you can read the docs [Login Kit](https://docs.snap.com/snap-kit/login-kit/overview).

> The **Client ID** is different for `Production` and `Staging` environment. So be careful to use the correct values.
> To use `Production` Client ID, your snapchat app should be approved and live on snapchat developer portal. [Read more](https://docs.snap.com/camera-kit/app-review/release-app) about submitting app for review.
## Installation
Before we can use the `snapchat_loginkit` plugin in our flutter app, it is necessary to perform platform-specific configuration setups first.

### Understand Scopes
[Snapchat Scopes](https://docs.snap.com/snap-kit/login-kit/Tutorials/android#understand-scopes) let your application declare which Login Kit features it wants access to. If a scope is toggleable, the user can deny access to one scope while agreeing to grant access to others.

### Android
In **:android** module, define `snap_connect_scopes` as an Android resource array in [`values/arrays.xml`](https://developer.android.com/guide/topics/resources/providing-resources#table1).

Define the following values in `local.properties` file under  **:android** module.

```properties
#sdk.dir=PATH_TO_ANDROID_SDK  

# staging env for snapkit  
com.snap.kit.clientId=YOUR_APP_CLIENT_ID
```
Inside the app's `build.gradle` use [manifestPlaceholders](https://developer.android.com/build/manage-manifests#inject_build_variables_into_the_manifest) attribute to pass these values to login kit. Read more about [configuring build types](https://developer.android.com/build/build-variants#build-types) in android.
- Depending on your requirements, you can either setup only one configuration for  all `productFlavors`
```groovy
android {
	defaultConfig {
		manifestPlaceholders = [  
                    SNAP_CLIENT_ID           : localProperties.getProperty("com.snap.kit.clientId"),
                    SNAP_REDIRECT_URL        : localProperties.getProperty("com.snap.kit.redirectUrl"),
                    SNAP_SCOPES_ARRAY        : "@array/snap_connect_scopes",
                    SNAP_REDIRECT_HOST       : localProperties.getProperty("com.snap.kit.host"),
                    SNAP_REDIRECT_PATH       : localProperties.getProperty("com.snap.kit.path"),
                    SNAP_REDIRECT_SCHEME     : localProperties.getProperty("com.snap.kit.scheme"),
                    FIREBASE_CUSTOM_TOKEN_URL: localProperties.getProperty("com.snap.kit.firebaseExtCustomTokenUrl")
		]
	}
	//...
}
```
- **OR** better way, setup different configurations for different `productFlavors`
```groovy
android {
	//...
	flavorDimensions "environment"
	productFlavors {
		staging {
			manifestPlaceholders = [  
                    		SNAP_CLIENT_ID           : localProperties.getProperty("com.snap.kit.clientId"),
                    		SNAP_REDIRECT_URL        : localProperties.getProperty("com.snap.kit.redirectUrl"),
                    		SNAP_SCOPES_ARRAY        : "@array/snap_connect_scopes",
                    		SNAP_REDIRECT_HOST       : localProperties.getProperty("com.snap.kit.host"),
                    		SNAP_REDIRECT_PATH       : localProperties.getProperty("com.snap.kit.path"),
				SNAP_REDIRECT_SCHEME     : localProperties.getProperty("com.snap.kit.scheme"),
				FIREBASE_CUSTOM_TOKEN_URL: localProperties.getProperty("com.snap.kit.firebaseExtCustomTokenUrl")
			]
		}
		production {
			manifestPlaceholders = [  
                    		SNAP_CLIENT_ID           : localProperties.getProperty("com.snap.kit.clientId"),
                    		SNAP_REDIRECT_URL        : localProperties.getProperty("com.snap.kit.redirectUrl"),
                    		SNAP_SCOPES_ARRAY        : "@array/snap_connect_scopes",
                    		SNAP_REDIRECT_HOST       : localProperties.getProperty("com.snap.kit.host"),
                    		SNAP_REDIRECT_PATH       : localProperties.getProperty("com.snap.kit.path"),
				SNAP_REDIRECT_SCHEME     : localProperties.getProperty("com.snap.kit.scheme"),
				FIREBASE_CUSTOM_TOKEN_URL: localProperties.getProperty("com.snap.kit.firebaseExtCustomTokenUrl")
			]
		}
	}
	//...
}
```
**NOTE:** The same properties name should be used as defined in the `local.properties` file.

### iOS
Add the following fields in your application’s `Info.plist` file:
```xml
<key>SCSDKClientId</key>
<string>$(SNAP_CLIENT_ID)</string>
<key>SCSDKRedirectUrl</key>
<string>$(SNAP_REDIRECT_URL)</string>
<key>SCSDKScopes</key>
<array>
    <string>https://auth.snapchat.com/oauth2/api/user.display_name</string>
    <string>https://auth.snapchat.com/oauth2/api/user.external_id</string>
    <string>https://auth.snapchat.com/oauth2/api/user.bitmoji.avatar</string>
</array>
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>snapchat</string>
</array>
<key>CFBundleURLTypes</key>
<array>
<dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLName</key>
    <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
    <key>CFBundleURLSchemes</key>
    <array>
        <string>$(SNAP_REDIRECT_SCHEME)</string>
    </array>x
</dict>
</array>
```
Read [Snapchat iOS Documentation](https://docs.snap.com/snap-kit/login-kit/Tutorials/ios#get-started) for more information.
#### Securing Your Client ID in Xcode
Adding a [Build Configuration](https://developer.apple.com/documentation/xcode/adding-a-build-configuration-file-to-your-project) file to your project for storing your client id and confidential keys. Let's add `SNAP_CLIENT_ID`, `SNAP_REDIRECT_URL` and `SNAP_REDIRECT_SCHEME` properties in configuration file.
```properties
// Configuration settings file format documentation can be found at:
// https://help.apple.com/xcode/#/dev745c5c974

// Snapchat Settings
SNAP_CLIENT_ID = YOUR_CLIENT_ID
SNAP_REDIRECT_URL = YOUR_REDIRECT_URL
SNAP_REDIRECT_SCHEME = YOUR_REDIRECT_SCHEME
```
- **OR** better way, setup different configurations file for different `productFlavors`

**NOTE:** Now, whenever we push code to our repo, we can make sure that config file does not reach the server by adding it in .gitignore

#### Handle Deeplink
In `AppDelegate`, use the `SCSDKLoginClient` interface to receive the deeplink:
```swift
import SCSDKLoginKit

func application(
  _ app: UIApplication,
  open url: URL,
  options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
  ...
    if SCSDKLoginClient.application(app, open: url, options: options) {
      return true
    }
  ...
}
```
After the keys setup, add `snapchat_loginkit:` as a dependency in your pubspec.yaml file.
Then run ```flutter pub get``` to install the package.

Now in your Dart code, you can use:
```dart
import 'package:snapchat_loginkit/snapchat_loginkit.dart';
```

## Access Loginkit in Flutter
### Initializing the Login
```dart
class _MyAppState extends State<MyApp> implements LoginStateCallback {
  late final SnapchatLoginkit _snapchatLoginkitPlugin;

  @override
  void initState() {
    super.initState();
    _snapchatLoginkitPlugin = SnapchatLoginkit(loginStateCallback: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Snapchat loginkit example'),
        ),
        body: Container(),
      ),
    );
  }

  @override
  void onFailure(String message) {
    // TODO: implement onFailure
  }

  @override
  void onLogout() {
   // TODO: implement onLogout
  }

  @override
  void onStart() {
    // TODO: implement onStart
  }

  @override
  void onSuccess(String accessToken) async {
     // TODO: implement onSuccess
  }
}
```
### Login with snapchat
```dart
 _snapchatLoginkitPlugin.login();
```
`When you call login, you will receive callbacks for onFailure, onLogout, onStart, and onSuccess.`

### Subscribe / Unsubscribe to Login State Updates
To subscribe to updates about the success of the login process, use `addLoginStateCallback()`. 
To unsubscribe from login updates, use `removeLoginStateCallback()`.

```dart
class _MyAppState extends State<MyApp> implements LoginStateCallback {
  late final SnapchatLoginkit _snapchatLoginkitPlugin;

  @override
  void initState() {
    super.initState();
    _snapchatLoginkitPlugin = SnapchatLoginkit(loginStateCallback: this);
    _snapchatLoginkitPlugin.addLoginStateCallback();
  }

  @override
  void dispose() {
     _snapchatLoginkitPlugin.removeLoginStateCallback();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Snapchat loginkit example'),
        ),
        body: Container(),
      ),
    );
  }

  @override
  void onFailure(String message) {
    // TODO: implement onFailure
  }

  @override
  void onLogout() {
   // TODO: implement onLogout
  }

  @override
  void onStart() {
    // TODO: implement onStart
  }

  @override
  void onSuccess(String accessToken) async {
     // TODO: implement onSuccess
  }
}
```

### Send Requests to Get User Data

Once a user logs into your app with Snapchat, you can make requests for their `displayName`, `AvatarUrl`, `AvatarId`, `externalId`, `tokenId` and `profileLink`.

Construct the user data query
```dart
    UserDataQuery query = UserDataQueryBuilder()
        .withDisplayName()
        .withBitmojiAvatarId()
        .withBitmojiAvatarUrl()
        .withExternalId()
        .withIdToken()
        .withProfileLink()
        .build();
```

Call the fetch API
```dart
UserResponse userResponse = await _snapchatLoginkitPlugin.fetchUserData(query);
debugPrint("User Code: ${userResponse.code}");
debugPrint("User Message: ${userResponse.message}");
debugPrint("User: ${userResponse.user}");
final displayName = userResponse.user.displayName;
final avatarUrl = userResponse.user.avatarUrl;
final avatarId = userResponse.user.avatarId;
final externalId = userResponse.user.externalId;
final tokenId = userResponse.user.tokenId;
final profileLink = userResponse.user.profileLink;
```

### Query Login State

To check whether a user is currently logged in, use `isUserLoggedIn()`

```dart
bool isUserLoggedIn = await _snapchatLoginkitPlugin.isUserLoggedIn();
```

### Fetch Access Token
Retrieve the access token after a successful login, use `fetchAccessToken()`
```dart
    final response = await _snapchatLoginkitPlugin.fetchAccessToken();
    debugPrint("Token Code: ${response.code}");
    debugPrint("Token Message: ${response.message}");
    debugPrint("Token Token: ${response.token}");
```

### Access To Scope 
Check if the user has granted access to a specific scope (permission) in their Snapchat account. use `hasAccessToScope('scope')`

```dart
 final bool hasAccess = await _snapchatLoginkitPlugin.hasAccessToScope('https://auth.snapchat.com/oauth2/api/user.display_name');
```

### Authenticate With Firebase 
Users to authenticate with Firebase using their Snapchat accounts. Define the `com.snap.kit.firebaseExtCustomTokenUrl=firebaseExtCustomTokenUrl` value in `local.properties` file under  **:android** module.
Before call this method `loginWithFirebase()` you should need to provide Firebase extension token url. for more help, how to generate firebase extension token url visit 
[Firebase Extension Token Url Android](https://docs.snap.com/snap-kit/login-kit/Tutorials/firebase/android#get-started) , [Firebase Extension Token Url iOS](https://docs.snap.com/snap-kit/login-kit/Tutorials/firebase/ios)

### Unlink
A user can choose to end the current OAuth2 Snapchat session and stop sharing their Display Name and Bitmoji avatar with your app. 
The `logout()` method can be used to clear the access.

```dart
 _snapchatLoginkitPlugin.logout();
```

## Bugs and feature requests

Have a bug or a feature request? Please first search for existing and closed issues. If your problem
or idea is not addressed
yet, [please open a new issue](https://github.com/DevCrew-io/snapchat_loginkit/issues/new).

## Author

[DevCrew I/O](https://devcrew.io/)
<h3 align=“left”>Connect with Us:</h3>
<p align="left">
<a href="https://devcrew.io" target="blank"><img align="center" src="https://devcrew.io/wp-content/uploads/2022/09/logo.svg" alt="devcrew.io" height="35" width="35" /></a>
<a href="https://www.linkedin.com/company/devcrew-io/mycompany/" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/linked-in-alt.svg" alt="mycompany" height="30" width="40" /></a>
<a href="https://github.com/DevCrew-io" target="blank"><img align="center" src="https://cdn-icons-png.flaticon.com/512/733/733553.png" alt="DevCrew-io" height="32" width="32" /></a>
</p>

## Contributing

Contributions, issues, and feature requests are welcome!

## Show your Support

Give a star if this project helped you.

