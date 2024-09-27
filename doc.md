## 1. Add new flavor App
* In `android/app/build.gradle`
```gradle
android {
      productFlavors{

          flavor {
            dimension "app"
            applicationId "com.example.app"
          }

          flavorProd {
            dimension "app"
            applicationId "com.example.app.prod"
          }

          flavorStaging {
            dimension "app"
            applicationId "com.example.app.staging"
          }
        }
  }
```

## 2. Add new configs file
* In `configs/flavor.json`
```json
{
  "APP_NAME": "App Name",
  "APP_SCHEME": "appscheme",
  "WEB_HOST": "example.com",
  "WWW_WEB_HOST": "www.example.com",
  "API_URL": "http://api.example.com",
  "CDN_IMAGE_URL": "http://images.example.com",
  "CLIENT_ID": "",
  "CLIENT_SECRET": "",
  "RECAPTCHA_IOS_KEY": "",
  "RECAPTCHA_ANDROID_KEY": "",
  "RECAPTCHA_WEB_KEY": "",
  "CRISP_WEBSITE_ID": "",
  "GOOGLE_CLIENT_ID": "******.apps.googleusercontent.com",
  "GOOGLE_REVERSE_CLIENT_ID": "com.googleusercontent.apps.******",
  "GOOGLE_MAP_KEY": "",
  "FB_APP_ID": "",
  "FB_CLIENT_TOKEN": "",
  "FB_LOGIN_PROTOCOL_SCHEME": "fb{ADD_FB_APP_ID_HERE}",
  "WEB_CLIENT": false
}
```
* Then add git ignore in `.gitignore`
```.gitignore
# find lines of code that have `configs/*`
configs/$flavor.json
```

## 3. Add script for generating `flavor.dart` in `firebase_options/`:
**This script will generates `flavor.dart` file in `lib/firebase_options/` and `main_flavor.dart` file**
* In `script/firebase_configure/exec.sh`
```exec.sh
function help(){

  # put this line of code under the this line `echo "Common commands:"`
  echo "  ./scripts/firebase_configure/exec.sh --flavor"

  # put this line of code under the this line `echo "options:"`
  echo "  --flavor       Setup project with development enviroment"
}

function main(){
  --flavor) # be able to use short cut of flavor
    enable_deferred_load_if_compiling_for_web
    configure 'flavor' 'central-market-internal' 'com.example.app' '1:339169869188:web:57d3de271722e03ca4b1d1' $2
    exit 0
    ;;
}
```
* After add the above script, run the follow command:
```bash
./scripts/firebase_configure/exec.sh --flavor
```

## 4. Create new flavor icon:
* Create folder `flavor_icons/` in `app/external_assets/` and store the icons in this folder
* Create folder `flavor_logo/` in `app/external_assets/`  and store the logo in this folder

## 5. Add generate launched icons for new flavor [![flutter_launcher_icons](https://img.shields.io/badge/Flutter%20Community-flutter__launcher__icons-blue)](https://pub.dev/packages/flutter_launcher_icons)
* Create a new `flutter_launcher_icons-flavor.yaml` file in `app/`
* In `flutter_launcher_icons-flavor.yaml`:
```yaml  
flutter_launcher_icons:
  image_path: "external_assets/flavor_logo/logo.png"

  android: "ic_launcher"
  adaptive_icon_background: "#FFFFFF"
  adaptive_icon_foreground: "external_assets/flavor_logo/logo.png"
  min_sdk_android: 21

  ios: true
  image_path_ios: "external_assets/flavor_logo/logo.png"
  remove_alpha_ios: true

  web:
    generate: true
    image_path: "external_assets/flavor_logo/logo.png"
    background_color: "#FFFFFF"
    theme_color: "#FFFFFF" # custom the flavor color

  windows:
    generate: false

  macos:
    generate: true
    image_path: "external_assets/flavor_logo/logo.png"
  ```
* After create `flutter_launcher_icons-flavor.yaml`, run the command:
```bash
flutter pub get
dart run flutter_launcher_icons -f flavor
```

## 6. Create new flavor splash image:
* Create folder `flavor_splash/` in `app/assets/` and store the image in this folder

## 7. Create Splash screen for new flavor app ![flutter_native_splash](https://img.shields.io/badge/flutter_native_splash-v2.4.0-blue)
* Create a new `flutter_native_splash-flavor.yaml` file in `app/` folder
* In `flutter_native_splash-flavor.yaml`:
```yaml
flutter_native_splash:
  color: "#faeceb" # custom the flavor color
  image: assets/flavor_splash/logo.png
  color_dark: "#140403" # custom the flavor color
  image_dark: assets/flavor_splash/logo.png

  # Android 12 handles the splash screen differently than previous versions.  Please visit
  # https://developer.android.com/guide/topics/ui/splash-screen
  # Following are Android 12 specific parameter.
  android_12:
    # Please note that the splash screen will be clipped to a circle on the center of the screen.
    # App icon with an icon background: This should be 960×960 pixels, and fit within a circle
    # 640 pixels in diameter.
    # App icon without an icon background: This should be 1152×1152 pixels, and fit within a circle
    # 768 pixels in diameter.
    image: assets/flavor_splash/logo.png
    icon_background_color: "#FFFFFF"
    image_dark: assets/flavor_splash/logo.png
    icon_background_color_dark: "#25222E" # custom the flavor color

  image_android: assets/flavor_splash/logo.png
  image_dark_android: assets/flavor_splash/logo.png
```
* After create `flutter_native_splash-flavor.yaml`, run the command:
```bash
# please make sure flutter_native_splash-flavor.yaml is in `app/` folder
dart run flutter_native_splash:create --path:flutter_native_splash-flavor.yaml
dart run flutter_native_splash:create --flavor flavor # example: prod, staging, dev, ...
```

## 8. Create new ThemeConfig and ThemeConstant for new flavor:
* Create `theme_config_flavor.dart` in `lib/core/theme/` folder
* Create `theme_constamt_flavor.dart` in `lib/core/theme/` folder

## 9. Update ThemeProvider:
* Update ThemeProvider() in `lib/provider/theme_provider.dart`
```dart
  ThemeData light() {
    switch (ApiConstant.appscheme) {
      case 'Flavor App Name': // example: bookmeplus
        return ThemeConfigFlavor.light().themeData;
      // ...
      // ...
      default:
        return ThemeConfig.light().themeData;
    }
  }

  ThemeData dark() {
    switch (ApiConstant.appName) {
      case 'Flavor App Scheme':
        return ThemeConfigFlavor.dark().themeData;
      // ...
      // ...
      default:
        return ThemeConfig.dark().themeData;
    }
  }
```

## 10. Update M3Color:
* Update M3Color() in `lib/core/theme/m3/m3_color.dart`:
```dart
  Color primaryColor() {
    switch (ApiConstant.appscheme) {
      case 'Flavor App Scheme': // example: bookmeplus
        return ThemeConstantFlavor.brandColor; // brand color of flavor
      default:
        return ThemeConstant.brandColor;
    }
  }
```



