import 'package:dio/dio.dart';

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

const int cacheMaxAge = 86400000;
const int cacheMaxCount = 1000;
const bool cacheEnable = false;

class CacheObject {
  CacheObject(this.response)
      : timeStamp = DateTime.now().millisecondsSinceEpoch;
  Response response;
  int timeStamp;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}

class NetCacheInterceptor extends Interceptor {
  // 为确保迭代器顺序和对象插入时间一致顺序一致，我们使用LinkedHashMap
  var cache = <String, CacheObject>{};
  var box = Hive.box('netBox');

  dynamic getJSON(String key) {
    String? jsonString = box.get(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }
  Future<void> setJSON(String key, dynamic jsonVal) {
    String jsonString = jsonEncode(jsonVal);
    return box.put(key, jsonString);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!cacheEnable) {
      return super.onRequest(options, handler);
    }

    // refresh标记是否是刷新缓存
    bool refresh = options.extra["refresh"] == true;

    // 是否磁盘缓存
    bool cacheDisk = options.extra["cacheDisk"] == true;

    // 如果刷新，先删除相关缓存
    if (refresh) {
      // 删除uri相同的内存缓存
      delete(options.uri.toString());

      // 删除磁盘缓存
      if (cacheDisk) {
        box.delete(options.uri.toString());
      }

      return;
    }

    // get 请求，开启缓存
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == 'get') {
      String key = options.extra["cacheKey"] ?? options.uri.toString();

      // 策略 1 内存缓存优先，2 然后才是磁盘缓存

      // 1 内存缓存
      var ob = cache[key];
      if (ob != null) {
        //若缓存未过期，则返回缓存内容
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 <
            cacheMaxAge) {
          return;
        } else {
          //若已过期则删除缓存，继续向服务器请求
          cache.remove(key);
        }
      }

      // 2 磁盘缓存
      if (cacheDisk) {
        var cacheData = getJSON(key);
        if (cacheData != null) {
          return;
        }
      }
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // 如果启用缓存，将返回结果保存到缓存
    if (cacheEnable) {
      await _saveCache(response);
    }
    return super.onResponse(response, handler);
  }

  Future<void> _saveCache(Response object) async {
    RequestOptions options = object.requestOptions;

    // 只缓存 get 的请求
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      // 策略：内存、磁盘都写缓存

      // 缓存key
      String key = options.extra["cacheKey"] ?? options.uri.toString();

      // 磁盘缓存
      if (options.extra["cacheDisk"] == true) {
        await setJSON(key, object.data);
      }

      // 内存缓存
      // 如果缓存数量超过最大数量限制，则先移除最早的一条记录
      if (cache.length == cacheMaxCount) {
        cache.remove(cache[cache.keys.first]);
      }

      cache[key] = CacheObject(object);
    }
  }

  void delete(String key) {
    cache.remove(key);
  }
}
