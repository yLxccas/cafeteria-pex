import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'clientLogin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dropdown Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedTable;
  bool isButtonEnabled = false;

  final List<String> tables = ['Mesa 1', 'Mesa 2', 'Mesa 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            DropdownButton<String>(
              hint: Text('Selecionar Mesa'),
              value: selectedTable,
              onChanged: (String? newValue) {
                setState(() {
                  selectedTable = newValue!;
                  updateButtonState();
                });
              },
              items: tables.map((String table) {
                return DropdownMenuItem<String>(
                  value: table,
                  child: Text(table),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  isButtonEnabled ? () => _saveSelectedTable(context) : null,
              child: Text('Prosseguir'),
            ),
          ],
        ),
      ),
    );
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = selectedTable != null;
    });
  }

  Future<void> _saveSelectedTable(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedTable', selectedTable!);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
