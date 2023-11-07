import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../style/color.dart';

/// 普通提示
void tipBar(String msg, {int time = 5, String title = '提示'}) {
  // Get.closeAllSnackbars();
  Get.closeCurrentSnackbar();
  Get.rawSnackbar(
      titleText: Text(
        title,
        style:
        const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      messageText: Text(
        msg,
        style: const TextStyle(color: Colors.black),
      ),
      icon: const Icon(
        LineIcons.infoCircle,
        color: Colors.black,
      ),
      borderRadius: 15,
      barBlur: 7,
      borderWidth: 1,
      borderColor: AppColor.mb,
      backgroundColor: Colors.white,
      // Colors.grey.withOpacity(0.2),
      snackStyle: SnackStyle.FLOATING,
      forwardAnimationCurve: Curves.easeOutCirc,
      reverseAnimationCurve: Curves.easeOutCirc,
      overlayBlur: 0.0,
      overlayColor: Colors.transparent,
      snackPosition: SnackPosition.TOP,
      padding: const EdgeInsets.all(16),
      isDismissible: true,
      margin: const EdgeInsets.all(16),
      duration: Duration(seconds: time),
      animationDuration: const Duration(milliseconds: 300),
      mainButton: TextButton(
          onPressed: () => Get.closeCurrentSnackbar(),
          child: Text(
            "OK",
            style: TextStyle(color: AppColor.officeColor()),
          )));
}

/// 询问是否
void askBar(String msg, Function confirm, Function cancel,
    {int time = 30, String title = '提示', dynamic c1, dynamic c2}) {
  Get.closeCurrentSnackbar();
  Get.rawSnackbar(
    title: title,
    message: msg,
    icon: const Icon(
      LineIcons.questionCircle,
      color: Colors.white,
    ),
    borderRadius: 15,
    barBlur: 7,
    backgroundColor: Colors.grey.withOpacity(0.2),
    snackStyle: SnackStyle.FLOATING,
    forwardAnimationCurve: Curves.easeOutCirc,
    reverseAnimationCurve: Curves.easeOutCirc,
    overlayBlur: 0.0,
    overlayColor: Colors.transparent,
    snackPosition: SnackPosition.BOTTOM,
    padding: const EdgeInsets.all(16),
    isDismissible: true,
    margin: EdgeInsets.fromLTRB((2 * Get.width) / 3, 0, 16, 16),
    duration: const Duration(seconds: 300),
    animationDuration: const Duration(milliseconds: 300),
    mainButton: Row(
      children: [
        TextButton(
          onPressed: () {
            confirm(c1);
            Get.closeCurrentSnackbar();
          },
          child: const Text("确定"),
        ),
        TextButton(
          onPressed: () {
            cancel(c2);
            debugPrint("finish");
            Get.closeCurrentSnackbar();
          },
          child: const Text("取消"),
        ),
      ],
    ),
  );
}
