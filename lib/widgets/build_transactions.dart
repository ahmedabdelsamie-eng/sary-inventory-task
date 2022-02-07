import 'package:flutter/material.dart';
import 'package:sary/models/transaction.dart';
import 'package:sary/shared/components/components.dart';

Widget buildTransactions(List<Transaction> transactions) {
  if (transactions.isEmpty) {
    return const Center(
      child: Text(
        'No Transaction yet !',
        style: TextStyle(fontSize: 24, color: Colors.black),
      ),
    );
  } else {
    return ListView.builder(
      itemCount: transactions.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final transaction = transactions[index];

        return TransactionContainer(transaction: transaction);
      },
    );
  }
}
