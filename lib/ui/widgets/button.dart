import 'package:flutter/material.dart';

import '../theme.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function onTap;
  final bool isLong;

  const MyButton(
      {Key? key,
      required this.label,
      required this.onTap,
      required this.isLong})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: isLong ? 350 : 120,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: primaryClr),
        alignment: Alignment.center,
        child: Text(label,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center),
      ),
    );
  }
}
