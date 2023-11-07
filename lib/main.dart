import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';


import 'common/langs/translation_service.dart';
import 'common/style/theme.dart';
import 'common/utils/logger.dart';
import 'common/router/routes.dart';
import 'global.dart';

int version = 1000000;
String versions = 'v1.0.0';

Future<void> main() async {

  await Global.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '我的APP',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initial,
      getPages: AppPages.routes,
      builder: (context, child) {
        GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
          child: child,
        );
        return EasyLoading.init()(context, child);
      },
      navigatorObservers: [AppPages.observer],
      translations: TranslationService(),
      locale: const Locale('zh', 'CN'),
      fallbackLocale: const Locale('en', 'US'),
      enableLog: true,
      logWriterCallback: Logger.write,
    );
  }
}
