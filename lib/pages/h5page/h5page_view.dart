import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'h5page_logic.dart';

class H5Page extends GetView<H5PageLogic> {
  const H5Page({super.key});

  @override
  Widget build(BuildContext context) {
    final String title = Get.arguments?['title'] ?? '';
    final String url = Get.arguments?['url'] ?? '';

    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: url.isNotEmpty
          ? WebViewWidget(controller: controller)
          : const Center(child: Text('无效的URL')),
    );
  }
} 