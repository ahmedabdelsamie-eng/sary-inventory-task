import 'package:hive/hive.dart';
part 'item.g.dart';

@HiveType(typeId: 1)
class Item extends HiveObject {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late double price;
  @HiveField(3)
  late String sku;
  @HiveField(4)
  late String description;
  @HiveField(5)
  late String image;
}
