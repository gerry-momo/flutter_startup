import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class H5PageWebView extends StatelessWidget {
  final String url;

  const H5PageWebView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));

    return WebViewWidget(controller: controller);
  }
} 