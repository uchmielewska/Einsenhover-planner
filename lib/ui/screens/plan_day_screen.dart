import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class PlanDayScreen extends StatefulWidget {
  const PlanDayScreen({super.key});

  @override
  State<PlanDayScreen> createState() => _PlanDayState();
}

class _PlanDayState extends State<PlanDayScreen> {
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
    );
  }
}
