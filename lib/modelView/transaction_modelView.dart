import 'package:flutter/material.dart';
import 'package:sary/shared/boxes.dart';

class TransactionModelView with ChangeNotifier {
  void deleteItemRelatedTransaction({String? itemId}) {
    print('deleted');
    final mybox = Boxes.getTransactions();
    bool indexExist = mybox.values.any((element) => element.itemId == itemId);
    if (!indexExist) return;
    final transactionRelated =
        mybox.values.firstWhere((t) => t.itemId == itemId);

    transactionRelated.delete();
    notifyListeners();
  }
}
