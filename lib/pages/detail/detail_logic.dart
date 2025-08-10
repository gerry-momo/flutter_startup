import 'package:get/get.dart';

import 'detail_state.dart';

class DetailLogic extends GetxController {
  final DetailState state = DetailState();

  @override
  void onInit() {
    state.hTodo = Get.arguments['hTodo'];
    state.textEditingController.text = state.hTodo.context.toString();
    state.textTitleController.text = state.hTodo.title.toString();
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
