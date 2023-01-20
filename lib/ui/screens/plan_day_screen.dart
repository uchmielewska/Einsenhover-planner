import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class MyPlanDayPage extends StatefulWidget {
  const MyPlanDayPage({super.key});

  @override
  State<MyPlanDayPage> createState() => _MyPlanDayPage();
}

class _MyPlanDayPage extends State<MyPlanDayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios, size: 20),
        ),
        actions: const [
          Icon(Icons.person, size: 20),
          SizedBox(width: 20),
        ]);
  }
}
