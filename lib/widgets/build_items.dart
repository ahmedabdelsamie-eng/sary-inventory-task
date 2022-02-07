import 'package:flutter/material.dart';
import 'package:sary/models/item.dart';
import 'package:sary/shared/components/components.dart';

Widget buildItems(List<Item> items) {
  if (items.isEmpty) {
    return const Center(
      child: Text(
        'No Items yet !',
        style: TextStyle(fontSize: 24, color: Colors.black),
      ),
    );
  } else {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];

        return ItemContainer(item: item);
      },
    );
  }
}
