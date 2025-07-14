import 'package:get/get.dart';
import '../../common/router/names.dart';
import 'setting_state.dart';

class SettingLogic extends GetxController {
  final SettingState state = SettingState();

  @override
  void onClose() {
    super.onClose();
    Get.delete<SettingLogic>();
  }

  void goToUserAgreement() {
    //Get.toNamed(Routes.USER_AGREEMENT);
    print('goToUserAgreement called');
    Get.toNamed(AppRoutes.userAgreement, arguments: {'title': '《用户协议》',
      'url':'https://st.music.163.com/official-terms?tab=service'
    });
  }

  void goToPrivacyPolicy() {
    Get.toNamed(AppRoutes.privacyPolicy, arguments: {'title': '《隐私条款》',
      'url':'https://st.music.163.com/official-terms?tab=privacy'
    });
  }
} 