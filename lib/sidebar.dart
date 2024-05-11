import 'package:flutter/material.dart';

void main() {
  runApp(SidebarWithMenu());
}

class SidebarWithMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HorizontalSidebar(),
                MenuItems(),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 200,
                    color: Colors.blueGrey,
                    child: Center(
                      child: Text(
                        'Conteúdo Adicional',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: Text(
                          'Conteúdo Principal',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HorizontalSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(167, 186, 86, 1),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60.0,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/donedu.png',
              width: 50,
              height: 50,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications, color: Colors.white),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.shopping_bag, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.transparent,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Center(
              child: Text(
                "Recomendações do dia",
                style: TextStyle(
                  color: Color(0xFF38312D),
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.asset(
                  'assets/images/bannerMenu.png',
                  width: 376,
                  height: 184,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                MenuItem(
                    imagePath: 'assets/images/saladaIcon.png', name: 'Saladas'),
                MenuItem(
                    imagePath: 'assets/images/ovoIcon.png', name: 'Omeletes'),
                MenuItem(
                    imagePath: 'assets/images/sanduicheIcon.png',
                    name: 'Sanduiches'),
                MenuItem(
                    imagePath: 'assets/images/paoIcon.png', name: 'Tostas'),
                MenuItem(
                    imagePath: 'assets/images/sopaIcon.png', name: 'Sopas'),
                MenuItem(
                    imagePath: 'assets/images/cafeIcon.png', name: 'Cafés'),
                MenuItem(
                    imagePath: 'assets/images/slacIcon.png', name: 'S/Lactose'),
                MenuItem(
                    imagePath: 'assets/images/bebidaIcon.png', name: 'Bebidas'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String imagePath;
  final String name;

  MenuItem({required this.imagePath, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: 46,
          height: 46,
        ),
        SizedBox(height: 5),
        Text(name),
      ],
    );
  }
}
