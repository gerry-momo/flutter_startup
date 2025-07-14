import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:line_icons/line_icons.dart';
import 'package:tapped/tapped.dart';

import '../../common/router/names.dart';
import '../../common/style/color.dart';
import '../../common/style/jn_style/jianan_utils.dart';
import '../../model/boxes.dart';
import '../../model/h_leds.dart';
import 'index_logic.dart';

class IndexPage extends GetView<IndexLogic> {
  IndexPage({super.key});

  var header = 'https://thirdwx.qlogo'
      '.cn/mmopen/vi_32/PiajxSqBRaEL3jj9QEQmd0YC8WCpq8IjpmicBEQMaf5JCGkb0zkv099XqI32ibaEUfEls5aOsJytoYmsQkia8mgSY9w1Nw7ljvTiaCMsqUT5Lk78WXKjsftfAhw/132';

  IndexLogic logic = Get.put(IndexLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeef1f3),
      appBar: AppBar(
        title: const Text(
          "TODO",
          style: TextStyle(
            color: Colors.white, // 标题文字为白色
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColor.blueBg, // 你可以根据实际调整
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.setting);
              },
              child: CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(header),
                backgroundColor: Colors.grey[200],
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5,),
              ValueListenableBuilder<Box<HTodo>>(
                  valueListenable: Boxes.getHTodo().listenable(),
                  builder: (context, box, _) {
                    final transactions = box.values.toList().cast<HTodo>();

                    /// 此处可以做过滤筛选

                    return ListView.builder(
                      itemCount: transactions.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                          child: NanUtils.boxContainer(
                              child: ListTile(
                            onTap: () {
                              transactions[index].done = !transactions[index].done;
                              transactions[index].save();
                              controller.update();
                            },
                            onLongPress: () {
                              transactions[index].delete();
                              controller.update();
                            },
                            title: Text(transactions[index].title),
                            leading: Icon((transactions[index].done) ? LineIcons.checkCircle : LineIcons.circle),
                            trailing: Tapped(
                                onTap: () {
                                  Get.toNamed(AppRoutes.detail, arguments: {'hTodo': transactions[index]});
                                },
                                child: const Icon(LineIcons.edit)),
                          )),
                        );
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          HTodo newTodo = HTodo()
            ..title = '一个TODO-${DateTime.now()}'
            ..context = '内容'
            ..done = false
            ..createdDate = DateTime.now()
            ..updateDate = DateTime.now();

          final todos = Boxes.getHTodo();
          todos.add(newTodo);
        },
        child: const Icon(LineIcons.plus),
      ),
    );
  }
}
