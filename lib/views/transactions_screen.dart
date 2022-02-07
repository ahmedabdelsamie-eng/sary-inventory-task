import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sary/modelView/transaction_modelView.dart';
import 'package:sary/models/transaction.dart';
import 'package:sary/shared/boxes.dart';
import 'package:sary/shared/components/components.dart';
import 'package:sary/views/items_screen.dart';
import 'package:sary/widgets/build_transactions.dart';
import 'package:sary/widgets/search_container.dart';
import 'package:sary/widgets/transaction_dialog.dart';

class TransactionScreen extends StatefulWidget {
  static const routeName = '/transaction-screen';

  const TransactionScreen({Key? key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late List<Transaction> transactions;
  String query = '';
  late Box<Transaction> transactionBox;

  @override
  void initState() {
    super.initState();
    transactionBox = Boxes.getTransactions();
    transactions = transactionBox.values.toList();
  }

  @override
  void dispose() {
    // Hive.box('transactions').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Transactions',
          ),
          actions: [
            IconButton(
              onPressed: () {
                navigateTo(context: context, routeName: ItemsScreen.routeName);
              },
              icon: const Icon(
                Icons.text_snippet_rounded,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                buildSearch(),
                if (query.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = transactions[index];

                        return TransactionContainer(
                          transaction: transaction,
                        );
                      },
                    ),
                  ),
                if (query.isEmpty)
                  Consumer<TransactionModelView>(
                    builder: (ctx, transactionMV, child) => Expanded(
                      child: ValueListenableBuilder<Box<Transaction>>(
                        valueListenable: Boxes.getTransactions().listenable(),
                        builder: (context, box, _) {
                          final transactions =
                              box.values.toList().cast<Transaction>();

                          return buildTransactions(transactions);
                        },
                      ),
                    ),
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AddButton(
                  function: () => showDialog(
                    context: context,
                    builder: (context) => TransactionDialog(
                      onClickedDone: addTransaction,
                    ),
                  ),
                  buttonText: ' Send',
                  buttonIcon: Icons.arrow_upward,
                  horizontalMargin: 0.0,
                  width: (MediaQuery.of(context).size.width - 15) / 2,
                ),
                const SizedBox(
                  width: 5,
                ),
                AddButton(
                  function: () => showDialog(
                    context: context,
                    builder: (context) => TransactionDialog(
                      onClickedDone: addTransaction,
                    ),
                  ),
                  buttonIcon: Icons.arrow_downward,
                  buttonText: ' Recieve',
                  width: (MediaQuery.of(context).size.width - 15) / 2,
                  horizontalMargin: 0.0,
                )
              ],
            )
          ],
        ),
      );
//search by transaction quantity or type or Inbound Date

  Widget buildSearch() => SearchTransactionContainer(
        onChanged: searchTransactionType,
      );

  void searchTransactionType(String query) {
    final trnsacs = transactionBox.values.toList().where((transaction) {
      final transType = transaction.type.toLowerCase();
      final transQuantity = transaction.quantity.toLowerCase();
      final transInbound = transaction.inboundAt.toLowerCase();

      final searchLower = query.toLowerCase();

      return transType.contains(searchLower) ||
          transQuantity.contains(searchLower) ||
          transInbound.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.transactions = trnsacs;
    });
  }

//end search process
//  add transaction in transaction box
  Future addTransaction(String id, String type, String itemId, String quantity,
      String inbound, String outbound) async {
    final itemBox = Boxes.getItems();
    bool itemExist = itemBox.values.any((element) => element.id == itemId);
    if (!itemExist) {
      showToast(msg: 'No Corresponding Item');

      return;
    }

    final transaction = Transaction()
      ..id = id
      ..type = type
      ..itemId = itemId
      ..quantity = quantity
      ..inboundAt = inbound
      ..outboundAt = outbound;

    final box = Boxes.getTransactions();
    box.add(transaction);
    showToast(msg: 'Transaction is done');
  }
}
