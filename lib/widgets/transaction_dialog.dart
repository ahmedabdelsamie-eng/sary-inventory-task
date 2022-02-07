import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sary/shared/components/components.dart';

class TransactionDialog extends StatefulWidget {
  final Function(
    String id,
    String type,
    String itemId,
    String quantity,
    String inboundAt,
    String outboundAt,
  ) onClickedDone;

  const TransactionDialog({
    Key? key,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _TransactionDialogState createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {
  final formKey = GlobalKey<FormState>();
  final idController = TextEditingController();

  final typeController = TextEditingController();
  final itemIdController = TextEditingController();

  final quantityController = TextEditingController();
  final inboundAtController = TextEditingController();
  final outboundAtController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    typeController.dispose();
    itemIdController.dispose();
    quantityController.dispose();
    inboundAtController.dispose();
    outboundAtController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = 'Add Transaction';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 8),
              buildDialogField(
                  text: 'Transaction Id',
                  controller: idController,
                  istransaction: true),
              const SizedBox(height: 8),
              buildDialogField(
                  text: 'Transaction Type',
                  controller: typeController,
                  istransaction: true),
              const SizedBox(height: 8),
              buildDialogField(
                  text: 'itemId',
                  controller: itemIdController,
                  istransaction: true),
              const SizedBox(height: 8),
              buildDialogField(
                  text: 'Quantity',
                  controller: quantityController,
                  istransaction: true),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  getDate(context, isInbound: true);
                },
                child: buildDialogField(
                    text: 'Inbound Date',
                    isDateField: true,
                    controller: inboundAtController,
                    istransaction: true),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  getDate(
                    context,
                  );
                },
                child: buildDialogField(
                    text: 'Outbound Date',
                    isDateField: true,
                    controller: outboundAtController,
                    istransaction: true),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildSubmitButton(
          context,
        ),
      ],
    );
  }

  void getDate(BuildContext context, {bool isInbound = false}) {
    print('22222222222222222222222222');
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.parse('2025-01-01'))
        .then((value) {
      isInbound
          ? inboundAtController.text = DateFormat.yMd().format(value!)
          : outboundAtController.text = DateFormat.yMd().format(value!);
    });
  }

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildSubmitButton(
    BuildContext context,
  ) {
    return TextButton(
      child: const Text('Add'),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final id = idController.text;
          final type = typeController.text;
          final itemId = itemIdController.text;
          final quantity = quantityController.text;
          final inbound = inboundAtController.text;
          final outbound = outboundAtController.text;

          widget.onClickedDone(id, type, itemId, quantity, inbound, outbound);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
