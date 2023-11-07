import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'detail_logic.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final logic = Get.put(DetailLogic());
  final state = Get
      .find<DetailLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailLogic>(builder: (logic) {
      return Scaffold(
        backgroundColor: Colors.orange,
        appBar: AppBar(
          title: Text(state.hTodo.title),
        ),
        body: SizedBox(
          width: Get.width,
          child: Column(
            children: [
              Text("内容 ${state.hTodo.context}"),

              TextButton(onPressed: () {
                state.hTodo.title = '修改后的标题';
                state.hTodo.save();

                // 刷新
                logic.update();
              }, child: const Text("修改标题")),

              TextButton(onPressed: () {
                state.hTodo.done = !state.hTodo.done;
                state.hTodo.save();
                // 删除todo
                // state.hTodo.delete();
              }, child: const Text("设置已完成/未完成")),

            ],
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    Get.delete<DetailLogic>();
    super.dispose();
  }
}
