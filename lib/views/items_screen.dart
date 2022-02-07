import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sary/models/item.dart';
import 'package:sary/shared/boxes.dart';
import 'package:sary/shared/components/components.dart';
import 'package:sary/shared/styles/colors.dart';
import 'package:sary/widgets/build_items.dart';
import 'package:sary/widgets/item_dialog.dart';

class ItemsScreen extends StatefulWidget {
  static const routeName = '/items-screen';

  const ItemsScreen({Key? key}) : super(key: key);

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  final List<Item> items = [];
  @override
  void dispose() {
    // Hive.box('appitems').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'Items',
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ValueListenableBuilder<Box<Item>>(
            valueListenable: Boxes.getItems().listenable(),
            builder: (context, box, _) {
              final items = box.values.toList().cast<Item>();

              return buildItems(items);
            },
          ),
          AddButton(
            buttonText: ' Add Item',
            buttonIcon: Icons.add,
            function: () => showDialog(
              context: context,
              builder: (context) => ItemDialog(
                onClickedDone: addItem,
              ),
            ),
          ),
        ],
      ),
    );
  }

//  add item in items box
  Future addItem(String id, String name, double price, String sku,
      String description, String image) async {
    final item = Item()
      ..id = id
      ..name = name
      ..price = price
      ..sku = sku
      ..description = description
      ..image = image;

    final box = Boxes.getItems();
    box.add(item);
    showToast(msg: 'Your Item Is Added');
  }
}
