import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

import 'package:test_url/Enums/platformsEnum.dart';

Platforms getCurrentPlatform() {
  if (kIsWeb) {
    return Platforms.web; //Platforms.ios for test ios ui without IOS simulator
  } else if (Platform.isIOS) {
    return Platforms.ios;
  } else if (Platform.isAndroid) {
    return Platforms.android;
  }
  return Platforms.android;
}

Platforms currentPlatform = getCurrentPlatform();
bool isOnWeb = currentPlatform == Platforms.web;
bool isOnIos = currentPlatform == Platforms.ios;
bool isOnAndroid = currentPlatform == Platforms.android;
