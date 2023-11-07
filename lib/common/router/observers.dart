import 'package:flutter/material.dart';
import 'routes.dart';

class RouteObservers<R extends Route<dynamic>> extends RouteObserver<R> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    var name = route.settings.name ?? '';
    if (name.isNotEmpty) AppPages.history.add(name);
    debugPrint('didPush');
    debugPrint("${AppPages.history}");
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    AppPages.history.remove(route.settings.name);
    debugPrint('didPop');
    debugPrint("${AppPages.history}");
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      var index = AppPages.history.indexWhere((element) {
        return element == oldRoute?.settings.name;
      });
      var name = newRoute.settings.name ?? '';
      if (name.isNotEmpty) {
        if (index > 0) {
          AppPages.history[index] = name;
        } else {
          AppPages.history.add(name);
        }
      }
    }
    debugPrint('didReplace');
    debugPrint("${AppPages.history}");
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    AppPages.history.remove(route.settings.name);
    debugPrint('didRemove');
    debugPrint("${AppPages.history}");
  }

  @override
  void didStartUserGesture(
      Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
  }
}
