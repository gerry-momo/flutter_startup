import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../pages/detail/detail_view.dart';
import '../../pages/index/index_view.dart';
import '../../pages/privacy/privacy_view.dart';
import '../middleware/router_welcome.dart';
import '../../pages/h5page/h5page_view.dart';
import 'routes.dart';
import '../../pages/setting/setting_view.dart';

class AppPages {
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    // 首页
    GetPage(
      name: AppRoutes.initial,
      page: () => IndexPage(),
      middlewares: [
        RouteWelcomeMiddleware(priority: 1),
      ],
    ),

    // 隐私页面
    GetPage(
      name: AppRoutes.privacy,
      page: () => const PrivacyPage(),
    ),

    GetPage(
      name: AppRoutes.detail,
      page: () => const DetailPage(),
    ),

    GetPage(
      name: AppRoutes.userAgreement,
      page: () => H5Page(),
    ),

    GetPage(
      name: AppRoutes.privacyPolicy,
      page: () => H5Page(),
    ),

    GetPage(
      name: AppRoutes.setting,
      page: () => SettingPage(),
    ),
  ];
}
