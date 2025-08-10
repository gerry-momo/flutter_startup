import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

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

  //这句注入不可缺
  IndexLogic logic = Get.put(IndexLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeef1f3),
      appBar: AppBar(
        title: const Text(
          "TODO-LIST",
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
              SizedBox(
                height: 5,
              ),
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
                              radius: 10,
                              child: ListTile(
                                onLongPress: () {
                                  _showActionSheet(context, transactions[index], index);
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
            ..title = '${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}'
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

  void _showActionSheet(BuildContext context, HTodo todo, int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // 顶部拖拽指示器
                Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // 操作选项
                ListTile(
                  leading: Icon(LineIcons.trash, color: Colors.red[600]),
                  title: Text('删除', style: TextStyle(color: Colors.red[600], fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.of(context).pop(); // 关闭操作菜单
                    _showDeleteConfirmDialog(context, todo);
                  },
                ),
                const Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey,
                  indent: 16,
                  endIndent: 16,
                ),
                ListTile(
                  leading: Icon(LineIcons.checkCircle, color: const Color(0xFF333333)),
                  title: const Text('标记为完成', style: TextStyle(color: Color(0xFF333333), fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.of(context).pop(); // 关闭操作菜单
                    todo.done = true;
                    todo.save();
                    controller.update();
                  },
                ),
                const Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey,
                  indent: 16,
                  endIndent: 16,
                ),
                ListTile(
                  leading: Icon(LineIcons.circle, color: const Color(0xFF333333)),
                  title: const Text('标记为未完成', style: TextStyle(color: Color(0xFF333333), fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.of(context).pop(); // 关闭操作菜单
                    todo.done = false;
                    todo.save();
                    controller.update();
                  },
                ),
                // 底部间距
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmDialog(BuildContext context, HTodo todo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text('确认删除', style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('确定要删除这条记录吗？此操作不可撤销。'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('取消', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                todo.delete();
                controller.update();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('删除', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}
