import 'package:hive_flutter/hive_flutter.dart';

import 'h_leds.dart';

class Boxes {
  static Box<HTodo> getHTodo() => Hive.box<HTodo>('HTodo');
}
