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
  final List<CartItem> _cart = [];

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

  void _addToCart(Product product, int quantity, String observation) {
    setState(() {
      _cart.add(CartItem(
          product: product, quantity: quantity, observation: observation));
      _selectedProduct = null; // Volta para a lista de produtos
    });
  }

  void _navigateToCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CartScreen(
              cart: _cart,
              onCheckout: _checkout,
              onCartItemPressed: _showCartItemDetails)),
    );
  }

// solicita fechar conta
  void _checkout() {
    if (_cart.isEmpty) {
      // Mostrar mensagem se o carrinho estiver vazio
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Comanda vazia'),
          content: Text('Você não adicionou nenhum item na comanda.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Mostrar diálogo de confirmação antes de fechar a comanda
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirmar fechamento'),
          content: Text('Você tem certeza que deseja fechar a comanda?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo de confirmação
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo de confirmação
                // Proceder com a solicitação de fechar a comanda se houver itens no carrinho
                setState(() {
                  _cart.clear();
                });
                Navigator.popUntil(context, ModalRoute.withName('/'));
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Solicitar conta'),
                    content: Text(
                        'Conta solicitada. Um garçom se dirigirá a sua mesa!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Confirmar'),
            ),
          ],
        ),
      );
    }
  }

// detalhes dos itens do carrinho
  void _showCartItemDetails(CartItem cartItem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(cartItem.product.name),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Quantidade: ${cartItem.quantity}'),
            if (cartItem.observation.isNotEmpty)
              Text('Observação: ${cartItem.observation}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            HorizontalSidebar(onCartPressed: () => _navigateToCart(context)),
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
                      addToCart: _addToCart,
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
  final VoidCallback onCartPressed;

  HorizontalSidebar({required this.onCartPressed});

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
                onPressed: onCartPressed,
                icon: Icon(Icons.shopping_bag, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//itens do menu
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
  final Function(Product, int, String) addToCart;

  ContentArea({
    required this.selectedMenuItem,
    required this.selectedProduct,
    required this.onProductSelected,
    required this.onBackButtonPressed,
    required this.addToCart,
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
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
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
      return ProductDetailsScreen(
        product: selectedProduct!,
        onBackButtonPressed: onBackButtonPressed,
        addToCart: addToCart,
      );
    }
  }
}

//detalhes do produto
class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  final VoidCallback onBackButtonPressed;
  final Function(Product, int, String) addToCart;

  ProductDetailsScreen(
      {required this.product,
      required this.onBackButtonPressed,
      required this.addToCart});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;
  final TextEditingController _observationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: widget.onBackButtonPressed,
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 5),
                  Text('Voltar'),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Image.asset(
              widget.product.imagePath,
              width: 300,
              height: 300,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
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
          SizedBox(height: 10),
          TextField(
            controller: _observationController,
            decoration: InputDecoration(
              labelText: 'Observação',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                widget.addToCart(
                    widget.product, _quantity, _observationController.text);
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

  Product(
      {required this.name, required this.description, required this.imagePath});
}

//item da sacola
class CartItem {
  final Product product;
  final int quantity;
  final String observation;

  CartItem(
      {required this.product,
      required this.quantity,
      required this.observation});
}

//tela da sacola
class CartScreen extends StatefulWidget {
  final List<CartItem> cart;
  final VoidCallback onCheckout;
  final Function(CartItem) onCartItemPressed;

  CartScreen({
    required this.cart,
    required this.onCheckout,
    required this.onCartItemPressed,
  });

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho de Compras'),
        backgroundColor: Color.fromRGBO(167, 186, 86, 1),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                final item = widget.cart[index];
                return ListTile(
                  leading: Image.asset(
                    item.product.imagePath,
                    width: 50,
                    height: 50,
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Text('Imagem não encontrada');
                    },
                  ),
                  title: Text(item.product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantidade: ${item.quantity}'),
                      if (item.observation.isNotEmpty)
                        Text('Observação: ${item.observation}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      _removeFromCart(item);
                    },
                  ),
                  onTap: () => widget.onCartItemPressed(item),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: widget.onCheckout,
              child: Text('Fechar Comanda'),
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

  void _removeFromCart(CartItem item) {
    setState(() {
      // encontra o índice do item no carrinho
      int index = widget.cart.indexOf(item);
      if (index != -1) {
        // remove o item da lista do carrinho
        widget.cart.removeAt(index);
        // exibe um SnackBar para informar que o item foi removido com sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Item removido do carrinho')),
        );
      }
    });
  }
}





//mappings
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
    Product(
      name: 'Salada Grega',
      description: 'Salada com pepino, tomate, azeitonas e queijo feta',
      imagePath: 'assets/images/saladaGrega.png',
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
    Product(
      name: 'Refrigerante',
      description: 'Refrigerante gelado',
      imagePath: 'assets/images/refrigerante.png',
    ),
    Product(
      name: 'Refrigerante',
      description: 'Refrigerante gelado',
      imagePath: 'assets/images/refrigerante.png',
    ),
  ],
};
