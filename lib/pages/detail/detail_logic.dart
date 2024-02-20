import 'package:get/get.dart';

import 'detail_state.dart';

class DetailLogic extends GetxController {
  final DetailState state = DetailState();

  @override
  void onInit() {
    state.hTodo = Get.arguments['hTodo'];
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    Get.delete<DetailLogic>();
  }
}
