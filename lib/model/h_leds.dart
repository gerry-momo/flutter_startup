import 'package:hive/hive.dart';

part 'h_leds.g.dart';

// 注意！每次修改Hive的数据模型时，需要执行以下命令生成 同名.g.dart 文件
// flutter pub run build_runner build --delete-conflicting-outputs

@HiveType(typeId: 0)
class HTodo extends HiveObject {
  @HiveField(0)
  late DateTime createdDate;

  @HiveField(1)
  late DateTime updateDate;

  // 标题
  @HiveField(2)
  late String title;

  // 内容
  @HiveField(3)
  late String context;

  // done
  @HiveField(4)
  late bool done;
}
