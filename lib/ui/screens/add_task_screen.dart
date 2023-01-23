import 'package:eisenhover_planner/ui/theme.dart';
import 'package:eisenhover_planner/ui/widgets/button.dart';
import 'package:eisenhover_planner/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedImportance = "ważne";
  final List<String> _importanceList = ["ważne", "nieważne"];

  String _selectedPrority = "pilne";
  final List<String> _prorityList = ["pilne", "niepilne"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Dodaj zadanie", style: headingStyle),
              MyInputField(
                  inputTitle: "Tytuł",
                  placeholder: "Dodaj tytuł zadania",
                  controller: _titleController),
              MyInputField(
                  inputTitle: "Opis",
                  placeholder: "Dodaj opis zadania",
                  controller: _descriptionController),
              _importanceSelect(context),
              _prioritySelect(context),
              Container(
                  padding: const EdgeInsets.only(top: 40),
                  child: MyButton(
                      label: "Utwórz zadanie",
                      onTap: () => _validateDate(),
                      isLong: true))
            ],
          ))),
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      // add to database
      Get.back();
    } else if (_titleController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.pink,
          colorText: Colors.white,
          icon: const Icon(Icons.warning_amber_rounded, color: Colors.white));
    }
  }

  _importanceSelect(BuildContext context) {
    return MyInputField(
        inputTitle: "Jak ważne?",
        placeholder: _selectedImportance,
        widget: DropdownButton(
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          iconSize: 32,
          elevation: 4,
          style: inputTitleStyle,
          underline: Container(height: 0),
          onChanged: (String? newValue) {
            setState(() {
              _selectedImportance = newValue!;
            });
          },
          items: _importanceList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ));
  }

  _prioritySelect(BuildContext context) {
    return MyInputField(
        inputTitle: "Jak pilne?",
        placeholder: _selectedPrority,
        widget: DropdownButton(
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          iconSize: 32,
          elevation: 4,
          style: inputTitleStyle,
          underline: Container(height: 0),
          onChanged: (String? newValue) {
            setState(() {
              _selectedPrority = newValue!;
            });
          },
          items: _prorityList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ));
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
