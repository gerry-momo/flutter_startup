import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global.dart';
import '../config.dart';
import '../router/names.dart';

/// Middleware
class RouteWelcomeMiddleware extends GetMiddleware {
  // priority 数字小优先级高
  @override
  int? priority = 0;

  RouteWelcomeMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (box.get(Config.isFirstOpen) ?? true) {
      debugPrint("==> 首次打开App 进入隐私协议页面");
      return const RouteSettings(name: AppRoutes.privacy);
    } else {
      debugPrint("非首次打开且已经同意隐私协议,不做拦截");
      return null;
    }
  }
}
