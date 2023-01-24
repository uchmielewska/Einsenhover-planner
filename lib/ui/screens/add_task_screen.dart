import 'package:eisenhover_planner/ui/theme.dart';
import 'package:eisenhover_planner/ui/widgets/button.dart';
import 'package:eisenhover_planner/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../business_logic/cubit/add_task/add_task_cubit.dart';

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                      onTap: () => _validateData(),
                      isLong: true))
            ],
          ))),
    );
  }

  _validateData() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _formKey.currentState?.validate() == true) {
      bool isPrior = _selectedPrority == "pilne";
      bool isImportant = _selectedImportance == "ważne";

      _formKey.currentState?.save();
      BlocProvider.of<AddTaskCubit>(context).addTask(_titleController.text,
          _descriptionController.text, isImportant, isPrior);
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
    );
  }
}
