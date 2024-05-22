import 'package:flutter/material.dart';

void main() {
  runApp(SidebarWithMenu());
}

class SidebarWithMenu extends StatefulWidget {
  @override
  _SidebarWithMenuState createState() => _SidebarWithMenuState();
}

class _SidebarWithMenuState extends State<SidebarWithMenu> {
  String _selectedMenuItem = 'Saladas';

  void _onMenuItemSelected(String itemName) {
    setState(() {
      _selectedMenuItem = itemName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            HorizontalSidebar(),
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 400,
                    child: MenuItems(onMenuItemSelected: _onMenuItemSelected),
                  ),
                  Expanded(
                    child: ContentArea(selectedMenuItem: _selectedMenuItem),
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
    );
  }
}

class MenuItems extends StatelessWidget {
  final Function(String) onMenuItemSelected;

  MenuItems({required this.onMenuItemSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                MenuItem(
                    imagePath: 'assets/images/saladaIcon.png',
                    name: 'Saladas',
                    onTap: onMenuItemSelected),
                MenuItem(
                    imagePath: 'assets/images/ovoIcon.png',
                    name: 'Omeletes',
                    onTap: onMenuItemSelected),
                MenuItem(
                    imagePath: 'assets/images/sanduicheIcon.png',
                    name: 'Sanduiches',
                    onTap: onMenuItemSelected),
                MenuItem(
                    imagePath: 'assets/images/paoIcon.png',
                    name: 'Tostas',
                    onTap: onMenuItemSelected),
                MenuItem(
                    imagePath: 'assets/images/sopaIcon.png',
                    name: 'Sopas',
                    onTap: onMenuItemSelected),
                MenuItem(
                    imagePath: 'assets/images/cafeIcon.png',
                    name: 'Cafés',
                    onTap: onMenuItemSelected),
                MenuItem(
                    imagePath: 'assets/images/slacIcon.png',
                    name: 'S/Lactose',
                    onTap: onMenuItemSelected),
                MenuItem(
                    imagePath: 'assets/images/bebidaIcon.png',
                    name: 'Bebidas',
                    onTap: onMenuItemSelected),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final Function(String) onTap;

  MenuItem({required this.imagePath, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(name),
      child: Column(
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
      ),
    );
  }
}

class ContentArea extends StatelessWidget {
  final String selectedMenuItem;

  ContentArea({required this.selectedMenuItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Conteúdo para $selectedMenuItem',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/${_getImageFileName(selectedMenuItem)}',
              width: 100,
              height: 100,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Text('Imagem não encontrada');
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getImageFileName(String menuItemName) {
    switch (menuItemName) {
      case 'Saladas':
        return 'saladaIcon.png';
      case 'Omeletes':
        return 'ovoIcon.png';
      case 'Sanduiches':
        return 'sanduicheIcon.png';
      case 'Tostas':
        return 'paoIcon.png';
      case 'Sopas':
        return 'sopaIcon.png';
      case 'Cafés':
        return 'cafeIcon.png';
      case 'S/Lactose':
        return 'slacIcon.png';
      case 'Bebidas':
        return 'bebidaIcon.png';
      default:
        return 'placeholder.png';
    }
  }
}
