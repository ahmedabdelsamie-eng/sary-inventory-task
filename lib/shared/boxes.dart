import 'package:hive/hive.dart';
import 'package:sary/models/item.dart';
import 'package:sary/models/transaction.dart';

class Boxes {
  static Box<Item> getItems() => Hive.box<Item>('appitems');

  static Box<Transaction> getTransactions() =>
      Hive.box<Transaction>('transactions');
}
