import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

class PlatformUtils {
  /// 检测当前运行的平台
  static String getCurrentPlatform() {
    if (kIsWeb) {
      return 'Web';
    } else if (Platform.isAndroid) {
      return 'Android';
    } else if (Platform.isIOS) {
      return 'iOS';
    } else if (Platform.isWindows) {
      return 'Windows';
    } else if (Platform.isLinux) {
      return 'Linux';
    } else if (Platform.isMacOS) {
      return 'macOS';
    } else {
      return 'Unknown';
    }
  }

  /// 是否为 Web 平台
  static bool get isWeb => kIsWeb;

  /// 是否为移动端平台
  static bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  /// 是否为桌面端平台
  static bool get isDesktop => !kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS);

  /// 是否为 Windows 平台
  static bool get isWindows => !kIsWeb && Platform.isWindows;

  /// 是否为 Linux 平台
  static bool get isLinux => !kIsWeb && Platform.isLinux;

  /// 是否为 macOS 平台
  static bool get isMacOS => !kIsWeb && Platform.isMacOS;

  /// 是否为 Android 平台
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  /// 是否为 iOS 平台
  static bool get isIOS => !kIsWeb && Platform.isIOS;

  /// 获取平台详细信息
  static Map<String, dynamic> getPlatformInfo() {
    if (kIsWeb) {
      return {
        'platform': 'Web',
        'userAgent': 'Web Browser',
        'isWeb': true,
        'isMobile': false,
        'isDesktop': false,
      };
    } else {
      return {
        'platform': Platform.operatingSystem,
        'version': Platform.operatingSystemVersion,
        'localHostname': Platform.localHostname,
        'isWeb': false,
        'isMobile': Platform.isAndroid || Platform.isIOS,
        'isDesktop': Platform.isWindows || Platform.isLinux || Platform.isMacOS,
        'isWindows': Platform.isWindows,
        'isLinux': Platform.isLinux,
        'isMacOS': Platform.isMacOS,
        'isAndroid': Platform.isAndroid,
        'isIOS': Platform.isIOS,
      };
    }
  }
} 