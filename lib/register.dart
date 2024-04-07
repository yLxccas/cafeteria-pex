import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importe o pacote shared_preferences
import 'clientLogin.dart'; // Importe a classe ClientLoginPage do arquivo clientLogin.dart

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
  String? selectedEmployee;
  String? selectedTable;
  bool isButtonEnabled = false;

  final List<String> employees = ['Employee 1', 'Employee 2', 'Employee 3'];
  final List<String> tables = ['Table 1', 'Table 2', 'Table 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              hint: Text('Select Employee'),
              value: selectedEmployee,
              onChanged: (String? newValue) {
                setState(() {
                  selectedEmployee = newValue!;
                  updateButtonState();
                });
              },
              items: employees.map((String employee) {
                return DropdownMenuItem<String>(
                  value: employee,
                  child: Text(employee),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              hint: Text('Select Table'),
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
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = selectedEmployee != null && selectedTable != null;
    });
  }

  Future<void> _saveSelectedTable(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedTable', selectedTable!);
    // Após salvar a mesa selecionada, navegue para a página ClientLoginPage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
