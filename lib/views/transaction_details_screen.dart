import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sary/models/item.dart';
import 'package:sary/models/transaction.dart';
import 'package:sary/shared/boxes.dart';
import 'package:sary/shared/components/components.dart';
import 'package:sary/shared/styles/colors.dart';

class TransactionDetails extends StatefulWidget {
  static const routeName = '/transaction-details';

  const TransactionDetails({Key? key}) : super(key: key);

  @override
  _TransactionDetailsState createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  var init = true;

  late Map<String, dynamic> routeArgs;
  late Box<Transaction> mybox;
  late Transaction myTransaction;
  late Item myItem;

  @override
  void didChangeDependencies() {
    if (init) {
      routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      mybox = Boxes.getTransactions();
      myTransaction =
          mybox.values.firstWhere((t) => t.id == routeArgs['transactionId']);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Transaction Details'),
      ),
      body: TransactionDetailsContainer(
        itemName: routeArgs['transactionItem']!.name,
        description: routeArgs['transactionItem']!.description,
        sku: routeArgs['transactionItem']!.sku,
        image: routeArgs['transactionItem']!.image,
        inboundAt: myTransaction.inboundAt,
        outboundAt: myTransaction.outboundAt,
        price: routeArgs['transactionItem']!.price,
        quantity: myTransaction.quantity,
        type: myTransaction.type,
      ),
    );
  }
}
