import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../global.dart';
import 'interceptor/cache.dart';
import 'interceptor/error.dart';
import 'interceptor/request.dart';
import 'interceptor/retry.dart';
// 拦截器

class Http {
  static final Http _instance = Http._internal();

  factory Http() => _instance;

  static late final Dio dio;

  List<CancelToken?> pendingRequest = [];

  Http._internal() {
    // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = BaseOptions();

    dio = Dio(options);

    // 添加request拦截器
    dio.interceptors.add(RequestInterceptor());
    // 添加error拦截器
    dio.interceptors.add(ErrorInterceptor());
    // // 添加cache拦截器
    dio.interceptors.add(NetCacheInterceptor());
    // // 添加retry拦截器
    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    );

    // 在调试模式下需要抓包调试 - 禁用HTTPS证书校验
    // if (PROXY_ENABLE) {
    //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //       (client) {
    //     client.findProxy = (uri) {
    //       return "PROXY $PROXY_IP:$PROXY_PORT";
    //     };
    //     //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true;
    //   };
    // }
  }

  // 初始化公共属性
  // [baseUrl] 地址前缀
  // [connectTimeout] 连接超时赶时间
  // [receiveTimeout] 接收超时赶时间
  // [interceptors] 基础拦截器
  void init({
    String? baseUrl,
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
    Map<String, String>? headers,
    List<Interceptor>? interceptors,
  }) {
    dio.options = dio.options.copyWith(
      baseUrl: baseUrl,
      connectTimeout: Duration(milliseconds: connectTimeout),
      receiveTimeout: Duration(milliseconds: receiveTimeout),
      headers: headers ?? const {},
    );
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }
  }

  // 关闭所有 pending dio
  void cancelRequests() {
    pendingRequest.map((token) => token!.cancel('dio cancel'));
  }

  // 添加用户认证信息
  // 读取本地配置
  Map<String, dynamic>? getAuthorizationHeader(Map<String, dynamic>? headers) {
    String? accessToken = Hive.box('configs').get('access_token');
    if (accessToken != null) {
      String token = 'Bearer $accessToken';

      if (headers == null) {
        headers = {'Authorization': token};
      } else {
        if (headers.containsKey('h5Base')) token = accessToken;
        headers['Authorization'] = token;
      }
    }

    ///
    /// 给所有请求拦截并添加 header
    ///
    if (headers == null) {
      headers = {"Content-Type": "application/json"};
    } else {
      if (!headers.containsKey('Content-Type')) {
        headers['Content-Type'] = "application/json";
      }
    }

    return headers;
  }

  // 获取cancelToken, 根据传入的参数查看使用者是否有动态传入cancel，没有就生成一个
  CancelToken createDioCancelToken(CancelToken? cancelToken) {
    CancelToken token = cancelToken ?? CancelToken();
    pendingRequest.add(token);
    return token;
  }

  Future get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool refresh = false,
    bool noCache = !cacheEnable,
    String? cacheKey,
    bool cacheDisk = false,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(
      extra: {
        "refresh": refresh,
        "noCache": noCache,
        "cacheKey": cacheKey,
        "cacheDisk": cacheDisk,
      },
    );
    Map<String, dynamic>? authorization =
        getAuthorizationHeader(requestOptions.headers);
    if (authorization != null) {
      requestOptions = requestOptions.copyWith(headers: authorization);
    }
    Response response;
    CancelToken dioCancelToken = createDioCancelToken(cancelToken);
    // debugPrint(">>> ERROR= s");
    response = await dio.get(
      path,
      queryParameters: params,
      options: requestOptions,
      cancelToken: dioCancelToken,
    );
    pendingRequest.remove(dioCancelToken);

    // 错误处理
    // debugPrint(">>> ERROR= end");

    return response.data;
  }

  Future post(
    String path, {
    Map<String, dynamic>? params,
    data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? authorization =
        getAuthorizationHeader(requestOptions.headers);
    if (authorization != null) {
      requestOptions = requestOptions.copyWith(headers: authorization);
    }
    CancelToken dioCancelToken = createDioCancelToken(cancelToken);
    var response = await dio.post(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: dioCancelToken,
    );
    pendingRequest.remove(dioCancelToken);
    return response.data;
  }

  Future put(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic>? authorization =
        getAuthorizationHeader(requestOptions.headers);
    if (authorization != null) {
      requestOptions = requestOptions.copyWith(headers: authorization);
    }
    CancelToken dioCancelToken = createDioCancelToken(cancelToken);
    // debugPrint(">> ${requestOptions.headers}");
    var response = await dio.put(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: dioCancelToken,
    );
    pendingRequest.remove(dioCancelToken);
    return response.data;
  }

  Future patch(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? authorization =
        getAuthorizationHeader(requestOptions.headers);
    if (authorization != null) {
      requestOptions = requestOptions.copyWith(headers: authorization);
    }
    CancelToken dioCancelToken = createDioCancelToken(cancelToken);
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: dioCancelToken,
    );
    pendingRequest.remove(dioCancelToken);
    return response.data;
  }

  Future delete(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic>? authorization =
        getAuthorizationHeader(requestOptions.headers);
    if (authorization != null) {
      requestOptions = requestOptions.copyWith(headers: authorization);
    }
    CancelToken dioCancelToken = createDioCancelToken(cancelToken);
    var response = await dio.delete(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: dioCancelToken,
    );
    pendingRequest.remove(dioCancelToken);
    return response.data;
  }
}
