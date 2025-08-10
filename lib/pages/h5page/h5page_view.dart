import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'h5page_logic.dart';

// 条件导入webview_flutter，只在非Web平台导入
import 'h5page_webview.dart' if (dart.library.html) 'h5page_web.dart';

class H5Page extends GetView<H5PageLogic> {
  const H5Page({super.key});

  @override
  Widget build(BuildContext context) {
    final String title = Get.arguments?['title'] ?? '';
    final String url = Get.arguments?['url'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: url.isNotEmpty
          ? H5PageWebView(url: url)
          : const Center(child: Text('无效的URL')),
    );
  }
} 