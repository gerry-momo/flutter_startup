import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'dart:ui_web' as ui_web;

// Web平台的iframe实现
class H5PageWebView extends StatefulWidget {
  final String url;

  const H5PageWebView({super.key, required this.url});

  @override
  State<H5PageWebView> createState() => _H5PageWebViewState();
}

class _H5PageWebViewState extends State<H5PageWebView> {
  late String _viewType;

  @override
  void initState() {
    super.initState();
    _viewType = 'iframe-${DateTime.now().millisecondsSinceEpoch}';
    _registerViewFactory();
  }

  void _registerViewFactory() {
    // 注册一个自定义的ViewFactory来创建iframe
    ui_web.platformViewRegistry.registerViewFactory(
      _viewType,
      (int viewId) {
        final iframe = html.IFrameElement()
          ..src = widget.url
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%'
          ..allowFullscreen = true
          ..allow = 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture';
        
        return iframe;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewType);
  }
} 