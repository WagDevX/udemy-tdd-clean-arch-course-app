import 'package:flutter/material.dart';

class PoupupItem extends StatefulWidget {
  const PoupupItem({required this.title, required this.icon, super.key});

  final String title;
  final Widget icon;

  @override
  State<PoupupItem> createState() => _PoupupItemState();
}

class _PoupupItemState extends State<PoupupItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        widget.icon,
      ],
    );
  }
}
