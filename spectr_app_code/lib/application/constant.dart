import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const APP_NAME = 'Flutter Catalog';
final kAppIcon =
    Image.asset('res/images/app_icon.png', height: 64.0, width: 64.0);
const APP_DESCRIPTION = '';
const GOOGLEPLAY_URL = '';
const GITHUB_URL = '';
const AUTHOR_SITE = 'http://x-wei.github.io';
const APPSTORE_URL = '';

final kPlatformType = getCurrentPlatformType();
// Whether the app is running on mobile phones (Android/iOS)
final kIsOnMobile =
    {PlatformType.Android, PlatformType.iOS}.contains(kPlatformType);

final kIsMobileOrWeb = kIsWeb ||
    defaultTargetPlatform == TargetPlatform.iOS ||
    defaultTargetPlatform == TargetPlatform.android;

/// ! Adapted from https://www.flutterclutter.dev/flutter/tutorials/how-to-detect-what-platform-a-flutter-app-is-running-on/2020/127/
enum PlatformType { web, iOS, Android, MacOS, Fuchsia, Linux, Windows, Unknown }

PlatformType getCurrentPlatformType() {
  // ! `Platform` is not available on web, so we must check web first.
  if (kIsWeb) {
    return PlatformType.web;
  }

  if (Platform.isMacOS) {
    return PlatformType.MacOS;
  }

  if (Platform.isFuchsia) {
    return PlatformType.Fuchsia;
  }

  if (Platform.isLinux) {
    return PlatformType.Linux;
  }

  if (Platform.isWindows) {
    return PlatformType.Windows;
  }

  if (Platform.isIOS) {
    return PlatformType.iOS;
  }

  if (Platform.isAndroid) {
    return PlatformType.Android;
  }

  return PlatformType.Unknown;
}
