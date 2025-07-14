import 'package:get/get.dart';

import 'h5page_state.dart';

class H5PageLogic extends GetxController {
  final H5PageState state = H5PageState();

  @override
  void dispose() {
    super.dispose();
    Get.delete<H5PageLogic>();
  }
}
