# snapchat_loginkit
Flutter plugin for integrating Snapchat LoginKit, providing a seamless authentication experience in Flutter apps.
## Features
With Snapchat Login Kit, you can:
-   Add a “**Log in With Snapchat**” button and allows users to quickly log in to your app using their Snapchat account.
-   Request the user’s Snapchat display name
-   Request the user’s Bitmoji
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
			SNAP_CLIENT_ID : localProperties.getProperty("com.snap.kit.clientId"),  
			SNAP_REDIRECT_URL : "your_actual_redirect_url",  
			SNAP_SCOPES_ARRAY : "@array/snap_connect_scopes",  
			SNAP_REDIRECT_HOST : "your_actual_redirect_host",  
			SNAP_REDIRECT_PATH : "your_actual_redirect_path",  
			SNAP_REDIRECT_SCHEME: "your_actual_redirect_scheme"  
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
				SNAP_CLIENT_ID : localProperties.getProperty("com.snap.kit.staging.clientId"),  
				SNAP_REDIRECT_URL : "your_actual_redirect_url",  
				SNAP_SCOPES_ARRAY : "@array/snap_connect_scopes",  
				SNAP_REDIRECT_HOST : "your_actual_redirect_host",  
				SNAP_REDIRECT_PATH : "your_actual_redirect_path",  
				SNAP_REDIRECT_SCHEME: "your_actual_redirect_scheme"  
			]
		}
		production {
			manifestPlaceholders = [  
				SNAP_CLIENT_ID : localProperties.getProperty("com.snap.kit.production.clientId"),  
				SNAP_REDIRECT_URL : "your_actual_redirect_url",  
				SNAP_SCOPES_ARRAY : "@array/snap_connect_scopes",  
				SNAP_REDIRECT_HOST : "your_actual_redirect_host",  
				SNAP_REDIRECT_PATH : "your_actual_redirect_path",  
				SNAP_REDIRECT_SCHEME: "your_actual_redirect_scheme"  
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
