import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SellerChip extends StatefulWidget {
  String title;
  Function(String) onSelected;
  final List<String> titleList;

  SellerChip({
    super.key,
    required this.onSelected,
    required this.title,
    required this.titleList,
  });

  @override
  State<SellerChip> createState() => _SellerChipState();
}

class _SellerChipState extends State<SellerChip> {

  List<Widget> choiceChips() {
    int selectedIndex = widget.titleList.indexOf(widget.title);
    List<Widget> chips = [];
    for (int i = 0; i < widget.titleList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: ChoiceChip(
          label: Text(widget.titleList[i]),
          avatar: selectedIndex == i ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
          labelStyle: const TextStyle(color: Colors.white),
          backgroundColor: Colors.black,
          selected: selectedIndex == i,
          selectedColor: Colors.orange,
          onSelected: (bool value) {
              selectedIndex = i;
              widget.onSelected(widget.titleList[selectedIndex]);
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: choiceChips(),
    );
  }
}
