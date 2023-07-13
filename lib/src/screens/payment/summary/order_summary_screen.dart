import 'package:eshop/src/models/cartItems.dart';
import 'package:eshop/src/screens/cart/components/btn_bottom.dart';
import 'package:eshop/src/screens/reciept/reciept_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../razorpay/razorpay.dart';
import '../components/btn_bottom_checkout.dart';
import '../components/checkout_actionbar.dart';
import '../components/wallet_options_list.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary(
      {Key? key, required this.totalPrice, required this.products})
      : super(key: key);
  final double totalPrice;
  final List<CartItem> products;
  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  final RazorPayIntegration _integration = RazorPayIntegration();
  @override
  void initState() {
    super.initState();
    _integration.intiateRazorPay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Summary'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            'Order Summary',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.products.length,
            itemBuilder: (context, index) {
              final product = widget.products[index];
              return ListTile(
                leading: Image.network(product.image!),
                title: Text(product.title!),
                subtitle: Text(
                    'Quantity: ${product.quantity}  Total Price: \$ ${product.price * product.quantity}'),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Final Price: \$${widget.totalPrice}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 360),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: buildAlignBtnBottom2(
                context, widget.products, widget.totalPrice),
          )

          // ElevatedButton(
          //   onPressed: () {
          //     // _integration.openSession(amount: widget.totalPrice);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) =>
          //             Builder(builder: (innerContext) => ReceiptPage()),
          //       ),
          //     );
          //     // Add your payment logic here
          //   },
          //   child: Text('Proceed to Payment'),
          // ),
        ],
      ),
    );
  }

  Align buildAlignBtnBottom2(
      BuildContext context, List<CartItem> cartItems, double finalPrice) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 80,
        color: Colors.white,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$ $finalPrice',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  _integration.openSession(amount: widget.totalPrice);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => Builder(
                  //         builder: (innerContext) => ReceiptPage(
                  //             totalPrice: widget.totalPrice,
                  //             products: widget.products)),
                  //   ),
                  // );
                  // Add your payment logic here
                },
                style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text('Proceed to payment',
                    style: TextStyle(fontSize: 20)))
          ],
        ),
      ),
    );
  }
}
