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
  Product? _selectedProduct;

  void _onMenuItemSelected(String itemName) {
    setState(() {
      _selectedMenuItem = itemName;
      _selectedProduct = null;
    });
  }

  void _onProductSelected(Product product) {
    setState(() {
      _selectedProduct = product;
    });
  }

  void _onBackButtonPressed() {
    setState(() {
      _selectedProduct = null;
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
                    child: ContentArea(
                      selectedMenuItem: _selectedMenuItem,
                      selectedProduct: _selectedProduct,
                      onProductSelected: _onProductSelected,
                      onBackButtonPressed: _onBackButtonPressed,
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
  final Product? selectedProduct;
  final Function(Product) onProductSelected;
  final VoidCallback onBackButtonPressed;

  ContentArea({
    required this.selectedMenuItem,
    required this.selectedProduct,
    required this.onProductSelected,
    required this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedProduct == null) {
      return Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Produtos em $selectedMenuItem',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: products[selectedMenuItem]?.length ?? 0,
                itemBuilder: (context, index) {
                  final product = products[selectedMenuItem]![index];
                  return Card(
                    child: ListTile(
                      leading: Image.asset(
                        product.imagePath,
                        width: 50,
                        height: 50,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Text('Imagem não encontrada');
                        },
                      ),
                      title: Text(product.name),
                      subtitle: Text(product.description),
                      onTap: () => onProductSelected(product),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return ProductDetails(
        product: selectedProduct!,
        onBackButtonPressed: onBackButtonPressed,
      );
    }
  }
}

class ProductDetails extends StatefulWidget {
  final Product product;
  final VoidCallback onBackButtonPressed;

  ProductDetails({required this.product, required this.onBackButtonPressed});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: widget.onBackButtonPressed,
          ),
          Center(
            child: Image.asset(
              widget.product.imagePath,
              width: 200,
              height: 200,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Text('Imagem não encontrada');
              },
            ),
          ),
          SizedBox(height: 20),
          Text(
            widget.product.name,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            widget.product.description,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quantidade:',
                style: TextStyle(fontSize: 18),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (_quantity > 1) _quantity--;
                      });
                    },
                  ),
                  Text(
                    _quantity.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Falta adicionar ação para adicionar ao carrinho aqui
              },
              child: Text('Adicionar ao Carrinho'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(167, 186, 86, 1),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final String description;
  final String imagePath;

  Product({required this.name, required this.description, required this.imagePath});
}

final Map<String, List<Product>> products = {
  'Saladas': [
    Product(
      name: 'Salada Caesar',
      description: 'Salada com alface, parmesão e molho caesar',
      imagePath: 'assets/images/saladaCaesar.png',
    ),
    Product(
      name: 'Salada Grega',
      description: 'Salada com pepino, tomate, azeitonas e queijo feta',
      imagePath: 'assets/images/saladaGrega.png',
    ),
  ],
  'Omeletes': [
    Product(
      name: 'Omelete de Queijo',
      description: 'Omelete com queijo cheddar derretido',
      imagePath: 'assets/images/omeleteQueijo.png',
    ),
    Product(
      name: 'Omelete de Presunto',
      description: 'Omelete com presunto e ervas',
      imagePath: 'assets/images/omeletePresunto.png',
    ),
  ],
  'Sanduiches': [
    Product(
      name: 'Sanduíche de Frango',
      description: 'Sanduíche com frango grelhado e salada',
      imagePath: 'assets/images/sanduicheFrango.png',
    ),
    Product(
      name: 'Sanduíche Vegano',
      description: 'Sanduíche com vegetais frescos e hummus',
      imagePath: 'assets/images/sanduicheVegano.png',
    ),
  ],
  'Tostas': [
    Product(
      name: 'Tosta de Queijo',
      description: 'Tosta com queijo derretido',
      imagePath: 'assets/images/tostaQueijo.png',
    ),
    Product(
      name: 'Tosta de Presunto',
      description: 'Tosta com presunto e queijo',
      imagePath: 'assets/images/tostaPresunto.png',
    ),
  ],
  'Sopas': [
    Product(
      name: 'Sopa de Legumes',
      description: 'Sopa com legumes frescos da estação',
      imagePath: 'assets/images/sopaLegumes.png',
    ),
    Product(
      name: 'Sopa de Tomate',
      description: 'Sopa cremosa de tomate',
      imagePath: 'assets/images/sopaTomate.png',
    ),
  ],
  'Cafés': [
    Product(
      name: 'Café Expresso',
      description: 'Café forte e encorpado',
      imagePath: 'assets/images/cafeExpresso.png',
    ),
    Product(
      name: 'Cappuccino',
      description: 'Café com leite vaporizado e espuma',
      imagePath: 'assets/images/cappuccino.png',
    ),
  ],
  'S/Lactose': [
    Product(
      name: 'Smoothie de Frutas',
      description: 'Smoothie com frutas frescas e sem lactose',
      imagePath: 'assets/images/smoothieFrutas.png',
    ),
    Product(
      name: 'Leite de Amêndoas',
      description: 'Leite vegetal feito de amêndoas',
      imagePath: 'assets/images/leiteAmendoas.png',
    ),
  ],
  'Bebidas': [
    Product(
      name: 'Suco de Laranja',
      description: 'Suco fresco de laranja',
      imagePath: 'assets/images/sucoLaranja.png',
    ),
    Product(
      name: 'Refrigerante',
      description: 'Refrigerante gelado',
      imagePath: 'assets/images/refrigerante.png',
    ),
  ],
};
