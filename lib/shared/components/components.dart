import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sary/modelView/transaction_modelView.dart';
import 'package:sary/models/item.dart';
import 'package:sary/models/transaction.dart';
import 'package:sary/shared/boxes.dart';
import 'package:sary/shared/styles/themes.dart';
import 'package:sary/views/transaction_details_screen.dart';

void navigateTo(
    {required BuildContext context,
    Widget? route,
    bool withReplace = false,
    required String routeName,
    Map<String, dynamic>? data}) {
  if (withReplace) {
    Navigator.of(context).pushReplacementNamed(routeName);
  } else {
    Navigator.of(context).pushNamed(routeName, arguments: data);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////
//build item container
class ItemContainer extends StatelessWidget {
  double? containerHeight;
  double? containerWidth;
  late Item item;

  ItemContainer({
    this.containerHeight = 120,
    this.containerWidth = double.infinity,
    required this.item,
  });
  @override
  Widget build(BuildContext context) {
    final price = item.price.toStringAsFixed(2);

    return Dismissible(
      key: Key(item.id),
      onDismissed: (direction) {
        Provider.of<TransactionModelView>(context, listen: false)
            .deleteItemRelatedTransaction(itemId: item.id);
        item.delete();
        showToast(msg: 'You Delete Item');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        height: containerHeight,
        width: containerWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 15,
            ),
            Container(
              height: 80,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(item.image), fit: BoxFit.fitHeight),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: appThemeData.textTheme.headline3,
                ),
                Text(
                  item.description,
                  style: appThemeData.textTheme.headline3,
                ),
                Text(
                  '${item.sku} SR',
                  style: appThemeData.textTheme.headline3,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$price SR',
                      style: appThemeData.textTheme.bodyText1,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////

Widget buildDialogField(
        {String? text,
        TextEditingController? controller,
        bool isPrice = false,
        bool isDateField = false,
        bool istransaction = false}) =>
    TextFormField(
      controller: controller,
      enabled: isDateField ? false : true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: istransaction ? 'Enter  $text' : 'Enter Item $text',
      ),
      validator: isPrice
          ? (val) => val != null && double.tryParse(val) == null
              ? 'Enter a valid number'
              : null
          : (val) => val != null && val.isEmpty ? 'Enter a $text' : null,
    );

////////////////////////////////////////////////////////////////////////////////////////////
//build transaction container
class TransactionContainer extends StatelessWidget {
  double? containerHeight;
  double? containerWidth;
  late Transaction transaction;

  TransactionContainer({
    this.containerHeight = 120,
    this.containerWidth = double.infinity,
    required this.transaction,
  });
  @override
  Widget build(BuildContext context) {
    final mybox = Boxes.getItems();
    final myItem =
        mybox.values.firstWhere((item) => item.id == transaction.itemId);
    return InkWell(
      onTap: () {
        navigateTo(
            context: context,
            routeName: TransactionDetails.routeName,
            data: {'transactionId': transaction.id, 'transactionItem': myItem});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        height: containerHeight,
        width: containerWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  myItem.name,
                  style: appThemeData.textTheme.headline3,
                ),
                Text(
                  myItem.description,
                  style: appThemeData.textTheme.headline3,
                ),
                Text(
                  '${myItem.sku} ml',
                  style: appThemeData.textTheme.headline3,
                ),
                Text(
                  '${myItem.price} SR',
                  style: appThemeData.textTheme.bodyText1,
                )
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(children: [
                  Text(
                    transaction.type,
                    style: appThemeData.textTheme.bodyText1,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  transaction.type == 'Stock In'
                      ? const Icon(
                          Icons.arrow_downward,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.arrow_upward,
                          color: Colors.red,
                        ),
                ]),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  transaction.type == 'Stock In'
                      ? transaction.inboundAt
                      : transaction.outboundAt,
                  style: appThemeData.textTheme.headline3,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////
class AddButton extends StatelessWidget {
  late Function function;
  late String buttonText;
  late IconData buttonIcon;

  double? width;
  double? horizontalMargin;
  AddButton(
      {required this.function,
      required this.buttonText,
      required this.buttonIcon,
      this.width = double.infinity,
      this.horizontalMargin = 20});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin!, vertical: 20),
      height: 60,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.deepPurpleAccent),
      child: TextButton.icon(
        icon: Icon(
          buttonIcon,
          color: Colors.white,
        ),
        label: Text(buttonText, style: appThemeData.textTheme.bodyText2),
        onPressed: () {
          function();
        },
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////

class TransactionDetailsContainer extends StatelessWidget {
  double? containerHeight;
  double? containerWidth;
  late String itemName;
  late String description;
  late double price;
  late String sku;
  late String image;
  late String type;

  late String quantity;
  late String inboundAt;
  late String outboundAt;

  TransactionDetailsContainer({
    this.containerHeight = 370,
    this.containerWidth = double.infinity,
    required this.itemName,
    required this.description,
    required this.price,
    required this.sku,
    required this.image,
    required this.type,
    required this.quantity,
    required this.inboundAt,
    required this.outboundAt,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      height: containerHeight,
      width: containerWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 70,
                  width: 90,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(image), fit: BoxFit.fitHeight),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Container(
                  height: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(itemName, style: appThemeData.textTheme.headline3),
                      Spacer(),
                      Text(description,
                          style: appThemeData.textTheme.headline3),
                      const SizedBox(
                        height: 3,
                      ),
                      Text('$sku ml', style: appThemeData.textTheme.headline3),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quantity,
                      style: appThemeData.textTheme.bodyText1,
                    ),
                    Text('Quantity', style: appThemeData.textTheme.headline3)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$price SR',
                      style: appThemeData.textTheme.bodyText1,
                    ),
                    Text('Price', style: appThemeData.textTheme.headline3)
                  ],
                ),
                Row(
                  children: [
                    Text(type, style: appThemeData.textTheme.bodyText1),
                    type == 'Stock Out'
                        ? const Icon(
                            Icons.arrow_upward,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.arrow_downward,
                            color: Colors.green,
                          )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Inbound',
              style: appThemeData.textTheme.headline1,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      inboundAt,
                      style: appThemeData.textTheme.bodyText1,
                    ),
                    Text(
                      'Date',
                      style: appThemeData.textTheme.headline1,
                    )
                  ],
                ),
                const SizedBox(
                  width: 70,
                ),
                Column(
                  children: [
                    Text(
                      DateFormat.jm().format(DateTime.now()),
                      style: appThemeData.textTheme.bodyText1,
                    ),
                    Text(
                      'Time',
                      style: appThemeData.textTheme.headline1,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Outbound',
              style: appThemeData.textTheme.headline1,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      outboundAt,
                      style: appThemeData.textTheme.bodyText1,
                    ),
                    Text(
                      'Date',
                      style: appThemeData.textTheme.headline1,
                    )
                  ],
                ),
                const SizedBox(
                  width: 70,
                ),
                Column(
                  children: [
                    Text(
                      DateFormat.jm().format(DateTime.now()),
                      style: appThemeData.textTheme.bodyText1,
                    ),
                    Text(
                      'Time',
                      style: appThemeData.textTheme.headline1,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showToast({String? msg}) {
  Fluttertoast.showToast(
      msg: msg!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.03);
}
