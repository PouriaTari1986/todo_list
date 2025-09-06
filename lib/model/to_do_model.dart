



import 'package:hive_flutter/hive_flutter.dart';

part 'to_do_model.g.dart';

@HiveType(typeId: 0)
class ToDoModel extends HiveObject{

  @HiveField(0)
  int id = -1;

  @HiveField(1)
  String title;

  @HiveField(2)
  String desciption;

  @HiveField(3)
  ToDoColor color;

  ToDoModel({required this.title,required this.desciption,required this.color, });

}

@HiveType(typeId:1)
enum ToDoColor{

  @HiveField(0)
  green(0xff7CC371),

  @HiveField(1)
  red(0xffF39494),

  @HiveField(2)
  blue(0xff170DF3),

  @HiveField(3)
  black(0xff000000);

  final int code;

  const ToDoColor(this.code);
}