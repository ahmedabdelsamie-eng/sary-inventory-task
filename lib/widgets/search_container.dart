import 'package:flutter/material.dart';

class SearchTransactionContainer extends StatefulWidget {
  late ValueChanged<String> onChanged;
  SearchTransactionContainer({required this.onChanged});

  @override
  State<SearchTransactionContainer> createState() =>
      _SearchTransactionContainerState();
}

class _SearchTransactionContainerState
    extends State<SearchTransactionContainer> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Colors.white),
              child: TextFormField(
                controller: controller,
                enabled: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: 'Search',
                  border: InputBorder.none,
                ),
                onChanged: widget.onChanged,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.filter,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
