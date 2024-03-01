import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'detail_logic.dart';

class DetailPage extends GetView<DetailLogic> {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailLogic>(
        init: DetailLogic(),
        builder: (logic) {
      return Scaffold(
        backgroundColor: Colors.orange,
        appBar: AppBar(
          title: Text(logic.state.hTodo.title),
        ),
        body: SizedBox(
          width: Get.width,
          child: Column(
            children: [
              Text("内容 ${logic.state.hTodo.context}"),
              TextButton(
                  onPressed: () {
                    logic.state.hTodo.title = '修改后的标题';
                    logic.state.hTodo.save();

                    // 刷新
                    logic.update();
                  },
                  child: const Text("修改标题")),
              TextButton(
                  onPressed: () {
                    logic.state.hTodo.done = !logic.state.hTodo.done;
                    logic.state.hTodo.save();
                    // 删除todo
                    // state.hTodo.delete();
                  },
                  child: const Text("设置已完成/未完成")),
            ],
          ),
        ),
      );
    });
  }
}
