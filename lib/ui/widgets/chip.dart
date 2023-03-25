import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SellerChip extends StatefulWidget {
  const SellerChip({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
    required this.icon
  });

  final String title;
  final void Function() onTap;
  final bool isSelected;
  final bool icon;

  @override
  State<SellerChip> createState() => _SellerChipState();
}

class _SellerChipState extends State<SellerChip> {
  @override
  Widget build(BuildContext context) {
    return ActionChip(
        label: widget.isSelected && widget.icon
            ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check,
              size: 18.0,
              color: Colors.orange,
            ),
            const SizedBox(width: 4),
            Text(widget.title),
          ],
        )
            : Text(widget.title),
        elevation: widget.isSelected ? 0 : 3,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        backgroundColor: widget.isSelected
            ? Colors.black
            : Colors.orange,
        labelStyle: widget.isSelected
            ? const TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.w500,
            fontSize: 16.0)
            : const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16.0),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
        shadowColor: Colors.orange,
        onPressed: () => widget.onTap()
    );
  }
}
