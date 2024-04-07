import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildHeader(),
        buildCardContent(),
      ],
    );
  }

  Widget buildHeader() {
    return Expanded(
      flex: 3,
      child: Container(
        color: const Color.fromRGBO(167, 186, 86, 1),
        child: Center(
          child: Image.asset(
            'assets/images/donedu.png',
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }

  Widget buildCardContent() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bem vindo ao Don Edu",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Aqui você pode visualizar o nosso cardápio e fazer seus pedidos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton() {
    return ElevatedButton(
      onPressed: () {
        // Adicione a funcionalidade desejada aqui
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(167, 186, 86, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 90.0,
        ),
        child: Text(
          "Pedir agora",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
