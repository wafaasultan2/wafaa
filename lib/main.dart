import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Service> services = [
    Service('خدمة 1', 'assets/service1.jpg', 100),
    Service('خدمة 2', 'assets/service2.jpg', 150),
    Service('خدمة 3', 'assets/service3.jpg', 200),
  ];

  List<Service> cartItems = [];

  void addToCart(Service service) {
    setState(() {
      cartItems.add(service);
    });
  }

  void removeFromCart(Service service) {
    setState(() {
      cartItems.remove(service);
    });
  }

  void navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(cartItems: cartItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('خدمات'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: navigateToCart,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          Service service = services[index];
          bool isInCart = cartItems.contains(service);
          return ListTile(
            leading: Image.asset(service.image),
            title: Text(service.name),
            subtitle: Text('السعر: \$${service.price}'),
            trailing: IconButton(
              icon: isInCart ? Icon(Icons.remove_shopping_cart) : Icon(Icons.add_shopping_cart),
              onPressed: () {
                if (isInCart) {
                  removeFromCart(service);
                } else {
                  addToCart(service);
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class Service {
  final String name;
  final String image;
  final double price;

  Service(this.name, this.image, this.price);
}

class CartPage extends StatelessWidget {
  final List<Service> cartItems;

  CartPage({required this.cartItems});

  double getTotalPrice() {
    double totalPrice = 0;
    for (Service item in cartItems) {
      totalPrice += item.price;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('السلة'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                Service service = cartItems[index];
                return ListTile(
                  leading: Image.asset(service.image),
                  title: Text(service.name),
                  subtitle: Text('السعر: \$${service.price}'),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'الإجمالي: \$${getTotalPrice()}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
           ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('بيانات العميل'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // واجهة إدخال بيانات الطلب والدفع
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'الاسم',
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'العنوان',
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'رقم الهاتف',
                          ),
                        ),
                        ElevatedButton(
                          child: Text('تأكيد الطلب والدفع'),
                          onPressed: () {
                            // قم بمعالجة بيانات الطلب والدفع هنا
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Text('تأكيد الطلب'),
          ),
        
    
        ],
      ),
      
    );
    
  }
  
}

