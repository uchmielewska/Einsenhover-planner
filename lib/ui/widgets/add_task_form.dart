import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/add_task/add_task_cubit.dart';
import 'input_field.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddTaskFormState();
  }
}

class AddTaskFormState extends State<AddTaskForm> {
  String _title = '';
  String _description = '';
  bool isPrior = true;
  bool isImportant = true;

  final TextEditingController _titleController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildNameField() {
    return MyInputField(
        inputTitle: "Tytuł",
        placeholder: "Dodaj tytuł zadania",
        controller: _titleController);
    // return TextFormField(
    //   decoration: const InputDecoration(labelText: 'Tytuł'),
    //   // validator: commonValidation,
    //   onSaved: (String? value) {
    //     if (value != null) {
    //       _title = value;
    //     }
    //   },
    // );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () => {
              if (_formKey.currentState?.validate() == true)
                {
                  _formKey.currentState?.save(),
                  BlocProvider.of<AddTaskCubit>(context).addTask(
                      _titleController.text, _description, isImportant, isPrior)
                }
            },
        child: Center(child: BlocBuilder<AddTaskCubit, AddTaskState>(
          builder: ((context, state) {
            if (state is AddTaskLoading) {
              return const CircularProgressIndicator();
            }

            return const Text("Utwórz zadanie");
          }),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildNameField(),
            const SizedBox(height: 100),
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
