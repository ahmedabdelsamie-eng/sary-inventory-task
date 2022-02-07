import 'package:flutter/material.dart';
import 'package:sary/shared/components/components.dart';

class ItemDialog extends StatefulWidget {
  final Function(
    String id,
    String name,
    double price,
    String sku,
    String description,
    String image,
  ) onClickedDone;

  const ItemDialog({
    Key? key,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _ItemDialogState createState() => _ItemDialogState();
}

class _ItemDialogState extends State<ItemDialog> {
  final formKey = GlobalKey<FormState>();
  final idController = TextEditingController();

  final nameController = TextEditingController();
  final priceController = TextEditingController();

  final skuController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    priceController.dispose();
    skuController.dispose();
    descriptionController.dispose();
    imageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = 'Add Item';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 8),
              buildDialogField(text: 'Id', controller: idController),
              const SizedBox(height: 8),
              buildDialogField(text: 'Name', controller: nameController),
              const SizedBox(height: 8),
              buildDialogField(
                  text: 'Price', controller: priceController, isPrice: true),
              const SizedBox(height: 8),
              buildDialogField(text: 'Sku', controller: skuController),
              const SizedBox(height: 8),
              buildDialogField(
                  text: 'Description', controller: descriptionController),
              const SizedBox(height: 8),
              buildDialogField(text: 'Image', controller: imageController)
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(
          context,
        ),
      ],
    );
  }

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(
    BuildContext context,
  ) {
    return TextButton(
      child: const Text('Add'),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final id = idController.text;
          final name = nameController.text;
          final price = double.tryParse(priceController.text) ?? 0;
          final sku = skuController.text;
          final description = descriptionController.text;
          final image = imageController.text;

          widget.onClickedDone(id, name, price, sku, description, image);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
