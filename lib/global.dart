import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'common/utils/emu/app_model.dart';
import 'common/utils/loading.dart';
import 'model/h_leds.dart';
import 'network/api.dart';
import 'network/http_utils.dart';

final box = Hive.box('configs');

/// 全局静态数据
class Global {
  /// 初始化
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    setSystemUi();
    Loading();

    // 初始化Hive
    await Hive.initFlutter();
    await Hive.openBox('configs');
    await Hive.openBox('netBox');

    // 注册Model
    Hive.registerAdapter(HTodoAdapter());
    await Hive.openBox<HTodo>('HTodo');

    // 初始化request类
    // 设置时dev模式 还是线上模式
    String appModel = AppModel.dev.name;
    if (kDebugMode) {
      appModel = AppModel.dev.name;
    } else {
      appModel = AppModel.prod.name;
    }
    HttpUtils.init(
      baseUrl:
          (appModel == AppModel.prod.name) ? Api.prodBaseUrl : Api.devBaseUrl,
    );

  }

  static void setSystemUi() {
    if (GetPlatform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}
