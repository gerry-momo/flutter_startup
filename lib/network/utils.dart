import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'api.dart';
import 'http_utils.dart';

Future<dynamic> getGetData(String uri,
    {Options? options,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? params}) async {
  try {
    var response = await HttpUtils.get(
      uri,
      options: (options != null)
          ? options
          : Options(
              // headers: (h5Base) ? {"h5Base": "1"} : null,
              validateStatus: (status) {
                if (status == 200 || status == 201 || status == 204) {
                  return true;
                } else {
                  return false;
                }
              },
            ),
      params: params,
    );
    // debugPrint("$response");
    return response;
  } on DioError catch (e) {
    debugPrint("错误码${e.response?.statusCode} == $e");
    if (e.response?.statusCode == 404) {
      return 404;
    }
    return null;
  }
}

// POST 数据
Future<dynamic> getPostData(String uri, data) async {
  try {
    var response = await HttpUtils.post(uri, data: data, options: Options(
      // headers: (h5Base) ? {"h5Base": "1"} : null,
      validateStatus: (status) {
        if (status == 500) {
          debugPrint('[500]内部错误');
          return true;
        }
        if (status == 200 || status == 201 || status == 204) {
          return true;
        } else {
          return false;
        }
      },
    ));
    // debugPrint("返回:$response");
    return response;
  } on DioError catch (e) {
    debugPrint("$e");
    return null;
  }
}


void demo(){
  var response = getGetData(Api.login);
}