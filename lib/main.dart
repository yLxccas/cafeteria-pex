import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'clientLogin.dart';
import 'register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? selectedTable = prefs.getString('selectedTable');
  runApp(MyApp(selectedTable: selectedTable));
}

class MyApp extends StatelessWidget {
  final String? selectedTable;

  MyApp({this.selectedTable});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: selectedTable != null
          ? LoginPage()
          : MyHomePage(), // Verifica se uma mesa foi previamente selecionada
    );
  }
}
