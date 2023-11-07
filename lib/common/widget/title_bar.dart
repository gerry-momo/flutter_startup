import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius:
                BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("示例标题",style: Get.textTheme.titleSmall,),
              )),
        )
      ],
    );
  }
}


Row buildTitleRow(String title, String context, {Color color = Colors.red}) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
        child: Container(
          height: 32,
          width: 4,
          color: color,
        ),
      ),
      Text(
        title,
        style: Get.textTheme.titleLarge,
      ),
      const SizedBox(
        width: 8,
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(10)),
            ),
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                context,
                style: Get.textTheme.titleSmall,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
