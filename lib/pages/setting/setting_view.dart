import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../common/router/names.dart';
import '../../common/style/color.dart';
import 'setting_logic.dart';

class SettingPage extends GetView<SettingLogic> {
  SettingPage({super.key});

  final SettingLogic logic = Get.put(SettingLogic());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingLogic>(
        init: SettingLogic(),
        builder: (logic) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                '设置',
                style: TextStyle(
                  color: Colors.white, // 标题文字为白色
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              backgroundColor: AppColor.blueBg, // 你可以根据实际调整
              iconTheme: const IconThemeData(
                color: Colors.white, // 返回按钮为白色
              ),
            ),
            body: Container(
              color: const Color(0xfff0f0f3),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  // 应用图标
                  Center(
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/image/tools.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'StartUp',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Version 10.2.5',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 34),
                  Divider(
                    height: 2,
                    thickness: 10,
                    color: Color(0xfff0f0f3), // 设置分割线颜色
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildMenuItem(context, '用户协议'),
                        _buildMenuItem(context, '隐私政策'),
                        _buildMenuItem(context, '检查更新'),
                      ],
                      // 设置ListView背景为白色
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      // 下面一行是关键
                      // 你可以用Container包裹ListView，或者直接用ListView的属性
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: const Color(0xfff0f0f3),
          );
        });
  }

  Widget _buildMenuItem(BuildContext context, String title) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: const TextStyle(color: Color(0xFF333333))),
          trailing: const Icon(Icons.chevron_right, color: Color(0xFF999999),),
          onTap: () {
            switch (title) {
              case '用户协议':
                controller.goToUserAgreement();
                break;

              case '隐私政策':
                controller.goToPrivacyPolicy();
                break;

              case '检查更新':
                // 先显示进度对话框
                EasyLoading.show(
                  status: '检查更新中...',
                  maskType: EasyLoadingMaskType.black,
                  dismissOnTap: false,
                );

                // 2秒后隐藏进度对话框并显示结果 Toast
                Future.delayed(Duration(seconds: 2), () {
                  EasyLoading.dismiss(); // 隐藏进度对话框

                  // 显示结果 Toast
                  EasyLoading.showToast(
                    '当前版本已经是最新版本',
                    duration: Duration(seconds: 2),
                    toastPosition: EasyLoadingToastPosition.bottom,
                  );
                });
                break;

              default:
                // 默认处理
                break;
            }
          },
        ),
        Divider(
          height: 1,
          indent: 16,
          endIndent: 16,
          color: Color(0xFFE5E5E5), // 设置分割线颜色
        ),
      ],
    );
  }
}
