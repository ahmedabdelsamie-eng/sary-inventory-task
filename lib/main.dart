import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sary/models/item.dart';
import 'package:sary/models/transaction.dart';
import 'package:sary/shared/styles/themes.dart';
import 'package:sary/views/items_screen.dart';
import 'package:sary/views/transaction_details_screen.dart';
import 'package:sary/views/transactions_screen.dart';

import 'modelView/transaction_modelView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());

  await Hive.openBox<Transaction>('transactions');
  Hive.registerAdapter(ItemAdapter());

  await Hive.openBox<Item>('appitems');

//protrait code
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TransactionModelView(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: appThemeData,
        home: TransactionScreen(),
        routes: {
          ItemsScreen.routeName: (ctx) => ItemsScreen(),
          TransactionDetails.routeName: (ctx) => TransactionDetails(),
          TransactionScreen.routeName: (ctx) => TransactionScreen(),
        },
      ),
    );
  }
}
