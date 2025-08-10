import 'package:flutter/material.dart';
import 'package:flutter_startup/common/style/color.dart';
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
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(logic.state.hTodo.title),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 标题行
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Text(
                          "标题：",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller:logic.state.textTitleController,
                            style: const TextStyle(fontSize: 16),
                            maxLines: null,
                            maxLength: 20,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      height: 1,
                      thickness: 0.5,
                      color: Colors.grey,
                      indent: 0,
                      endIndent: 0,
                    ),
                    const SizedBox(height: 10),
                    // 内容行
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Text(
                          "内容：",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: logic.state.textEditingController,
                            maxLines: null,
                            maxLength: 300,
                            style: const TextStyle(fontFamily: 'meme', fontSize: 26),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      height: 1,
                      thickness: 0.5,
                      color: Colors.grey,
                      indent: 0,
                      endIndent: 0,
                    ),
                    const SizedBox(height: 20),
                    // 完成按钮
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          logic.state.hTodo.done = true;
                          logic.state.hTodo.title = logic.state.textTitleController.text.toString();
                          logic.state.hTodo.context = logic.state.textEditingController.text.toString();
                          logic.state.hTodo.save();
                          // 返回上级界面
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          backgroundColor: Colors.blue[600],
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "完成",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
