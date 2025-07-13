import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:line_icons/line_icons.dart';
import 'package:tapped/tapped.dart';
import '../../common/config.dart';
import '../../common/router/names.dart';
import '../../common/style/color.dart';
import '../../common/style/fonts.dart';
import '../../common/style/jn_style/jianan_utils.dart';
import '../../global.dart';
import 'privacy_logic.dart';
import 'package:flutter/gestures.dart';

class PrivacyPage extends GetView<PrivacyLogic> {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrivacyLogic>(
        init: PrivacyLogic(),
        builder: (logic) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  //渐变位置
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff00c0fa), Color(0xff015eea)]),
            ),
            child: Stack(
              children: [
                SizedBox(width: Get.width, height: Get.height),
                SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(30),
                          child: NanUtils.boxContainer(
                            radius: 12,
                            boxShadow: <BoxShadow>[
                              const BoxShadow(
                                  color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 8.0, spreadRadius: 0.0),
                            ],
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(LineIcons.book),
                                      Text(
                                        'privacy'.tr,
                                        style: Fonts.bigTip,
                                      )
                                    ],
                                  ),
                                  const Divider(),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: 350,
                                    ),
                                    child: Tapped(
                                      onTap: () async {},
                                      child: SingleChildScrollView(
                                        child: Text(
                                          'privacy1'.tr,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Text.rich(
                                      TextSpan(
                                        text: "阅读完整版",
                                        style: TextStyle(fontSize: 13, color: Colors.black),
                                        children: [
                                          TextSpan(
                                            text: "《用户协议》",
                                            style: TextStyle(color: Colors.blue, fontSize: 13),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                logic.goToUserAgreement();
                                              },
                                          ),
                                          TextSpan(
                                            text: "和",
                                            style: TextStyle(color: Colors.black, fontSize: 13),
                                          ),
                                          TextSpan(
                                            text: "《隐私条款》",
                                            style: TextStyle(color: Colors.blue, fontSize: 13),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                logic.goToPrivacyPolicy();
                                              },
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Tapped(
                                          child: NanUtils.boxContainer(
                                              radius: 12,
                                              height: 45,
                                              color: AppColor.greyTag,
                                              child: const Center(
                                                  child: Text(
                                                "退出",
                                                style: TextStyle(color: Colors.black87, letterSpacing: 4, fontSize: 16),
                                              ))),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Tapped(
                                          onTap: () {
                                            box.put(Config.isFirstOpen, false);
                                            logic.update();
                                            Get.offAndToNamed('/');
                                          },
                                          child: NanUtils.boxContainer(
                                              radius: 12,
                                              height: 45,
                                              color: AppColor.blueBtn,
                                              child: const Center(
                                                  child: Text(
                                                "同意并进入",
                                                style: TextStyle(color: Colors.white, letterSpacing: 4, fontSize: 16),
                                              ))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
