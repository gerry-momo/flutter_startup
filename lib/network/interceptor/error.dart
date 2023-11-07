import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../app_exceptions.dart';
// 异常

class MyDioSocketException implements SocketException {
  @override
  String message;

  @override
  final InternetAddress? address;

  @override
  final OSError? osError;

  @override
  final int? port;

  MyDioSocketException(
    this.message, {
    this.osError,
    this.address,
    this.port,
  });
}

// 错误处理拦截器
class ErrorInterceptor extends Interceptor {
  // 是否有网
  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    debugPrint(">>> Error ${err.error} ${err.response?.data} $handler");


    if (err.error is SocketException) {
      debugPrint("SocketException Error");
    }
    // 是否已经连接了网络，不判断是否没网
    if (err.type == DioErrorType.unknown) {
      bool isConnectNetWork = await isConnected();
      if (!isConnectNetWork && err.error is MyDioSocketException) {
        /// err.error.message = "当前无网络，请连接网络";
        debugPrint('当前无网络，请连接网络');
      } else {
        /// err.error.message = "当前网络不可用，请检查您的网络";
        debugPrint('当前网络不可用，请检查您的网络');
      }
    }

    /// error统一处理
    /// 自定义的统一处理
    AppException appException = AppException.create(err);

    // 错误提示

    return super.onError(err, handler);
  }
}
