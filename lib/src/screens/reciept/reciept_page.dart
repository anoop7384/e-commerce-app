import 'package:eshop/database.dart';
import 'package:eshop/src/models/orders.dart';
import 'package:eshop/src/models/products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eshop/src/screens/home/home_screen.dart';
import '../../models/cartItems.dart';

class ReceiptPage extends StatefulWidget {
  const ReceiptPage(
      {Key? key, required this.totalPrice, required this.products})
      : super(key: key);
  final double totalPrice;
  final List<CartItem> products;

  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    addOrder();
  }

  void addOrder() {
    final user = FirebaseAuth.instance.currentUser;
    List<PlacedOrder> orders = [];
    DateTime currentDateTime = DateTime.now();
    DateTime futureDateTime = currentDateTime.add(const Duration(days: 10));
    for (var product in widget.products) {
      removeFromCart(user!.uid.toString(), product.id.toString());
      Product pro = Product(
          id: product.id,
          title: product.title,
          image: product.image,
          description: product.description,
          price: product.price);

      PlacedOrder or = PlacedOrder(
          product: pro,
          status: "Shipped",
          orderDate: currentDateTime,
          expectedDeliveryDate: futureDateTime,
          totalAmount: widget.totalPrice,
          quantity: product.quantity!);

      orders.add(or);
    }
    addOrdersToDB(user!.uid.toString(), orders);
  }

  @override
  Widget build(BuildContext context) {
    final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    final Animation<double> _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    return Scaffold(
        body: Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizeTransition(
                sizeFactor: _animation,
                axis: Axis.horizontal,
                axisAlignment: -1,
                child: Container(
                    child: Image.asset(
                  'assets/images/success.png',
                  fit: BoxFit.contain,
                  color: Colors.indigo,
                  height: 100,
                  width: 100,
                ))),
            const SizedBox(height: 10),
            const Text(
              ' You have successfully placed your order !!',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
            const SizedBox(height: 20),
            const Text(
              ' Thank You for shopping with us !!',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text('Shop Again', style: TextStyle(fontSize: 20)))
          ],
        ),
      ),
    ));
  }
}
