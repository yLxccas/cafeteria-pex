import 'package:flutter/material.dart';
import 'sidebar.dart';

void main() {
  runApp(Menu());
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SidebarWithMenu(),
    );
  }
}
