import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';

class MyInputField extends StatelessWidget {
  final String inputTitle;
  final String placeholder;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputField(
      {Key? key,
      required this.inputTitle,
      required this.placeholder,
      this.controller,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(inputTitle, style: inputTitleStyle),
            Container(
                height: 52,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.only(left: 14),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                            readOnly: widget != null,
                            autofocus: false,
                            cursorColor: Get.isDarkMode
                                ? Colors.grey[100]
                                : Colors.grey[700],
                            controller: controller,
                            style: placeholderStyle,
                            decoration: InputDecoration(
                              hintText: placeholder,
                              hintStyle: placeholderStyle,
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.white)),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.white)),
                            ))),
                    widget == null ? Container() : Container(child: widget)
                  ],
                ))
          ],
        ));
  }
}
