import 'package:get/get.dart';

import 'index_state.dart';

class IndexLogic extends GetxController {
  final IndexState state = IndexState();

  @override
  void dispose() {
    super.dispose();
    Get.delete<IndexLogic>();
  }
}
