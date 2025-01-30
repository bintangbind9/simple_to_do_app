import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

enum AppPlatform {
  web,
  android,
  fuchsia,
  iOS,
  linux,
  macOS,
  windows,
}

AppPlatform get getCurrentPlatform {
  if (kIsWeb) return AppPlatform.web;
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return AppPlatform.android;
    case TargetPlatform.fuchsia:
      return AppPlatform.fuchsia;
    case TargetPlatform.iOS:
      return AppPlatform.iOS;
    case TargetPlatform.linux:
      return AppPlatform.linux;
    case TargetPlatform.macOS:
      return AppPlatform.macOS;
    case TargetPlatform.windows:
      return AppPlatform.windows;
  }
}

class PlatformUtil {
  AppPlatform get currentPlatform => getCurrentPlatform;
}
