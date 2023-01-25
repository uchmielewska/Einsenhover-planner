import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../business_logic/cubit/add_task/add_task_cubit.dart';
import '../theme.dart';
import 'input_field.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddTaskFormState();
  }
}

class AddTaskFormState extends State<AddTaskForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> _importanceList = ["ważne", "nieważne"];
  final List<String> _prorityList = ["pilne", "niepilne"];
  String _selectedImportance = "ważne";
  String _selectedPrority = "pilne";

  Widget _buildNameField() {
    return MyInputField(
        inputTitle: "Tytuł",
        placeholder: "Dodaj tytuł zadania",
        controller: _titleController);
  }

  Widget _buildDescriptionField() {
    return MyInputField(
        inputTitle: "Opis",
        placeholder: "Dodaj opis zadania",
        controller: _descriptionController);
  }

  Widget _buildImportanseSelect() {
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

  Widget _buildPrioritySelect() {
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

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {
        if (_titleController.text.isNotEmpty &&
            _descriptionController.text.isNotEmpty &&
            _formKey.currentState?.validate() == true)
          {
            _formKey.currentState?.save(),
            BlocProvider.of<AddTaskCubit>(context).addTask(
                _titleController.text,
                _descriptionController.text,
                _selectedPrority == "pilne",
                _selectedImportance == "ważne")
          }
        else if (_titleController.text.isEmpty ||
            _descriptionController.text.isEmpty)
          {
            Get.snackbar("Required", "All fields are required!",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.pink,
                colorText: Colors.white,
                icon: const Icon(Icons.warning_amber_rounded,
                    color: Colors.white))
          }
      },
      child: Center(child: BlocBuilder<AddTaskCubit, AddTaskState>(
        builder: ((context, state) {
          if (state is AddTaskLoading) {
            return const CircularProgressIndicator();
          }

          return const Text("Utwórz zadanie");
        }),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        _buildNameField(),
        _buildDescriptionField(),
        _buildImportanseSelect(),
        _buildPrioritySelect(),
        const SizedBox(height: 80),
        _buildSubmitButton(context)
      ]),
    );
  }
}

String commonValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Pole jest wymagane';
  }
  return '';
}
