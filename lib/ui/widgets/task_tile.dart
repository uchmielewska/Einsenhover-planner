import 'package:flutter/material.dart';

class MyTaskTile extends StatelessWidget {
  final String id;
  final String title;

  const MyTaskTile({
    Key? key,
    required this.id,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
          ],
        ),
      ),
    );
  }
}
