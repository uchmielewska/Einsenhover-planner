import 'package:flutter/material.dart';

import '../router/routes.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index, BuildContext context) {
    setState(() {
      _selectedIndex = index;
    });

    Navigator.of(context).pushNamed(_paths[index]);
    ModalRoute.of(context)?.settings.name == _paths[index];
  }

  int _currentIndex(BuildContext context) {
    final index = _paths
        .indexWhere((path) => ModalRoute.of(context)?.settings.name == path);

    final a = ModalRoute.of(context)?.settings.name;

    if (index < 0) {
      return 0;
    }

    return index;
  }

  final List<String> _paths = [homeRoute, addTaskRoute, planDayRoute];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Twój dzień',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Dodaj zadanie',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: 'Planuj',
        ),
      ],
      currentIndex: _currentIndex(context),
      selectedItemColor: Colors.grey,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        _onItemTapped(index, context);
      },
    );
  }
}
