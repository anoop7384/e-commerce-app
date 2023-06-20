import 'package:eshop/src/models/cartItems.dart';
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
        title: Text('Order Summary'),
      ),
      body: Column(
        children: [
          // Add your other checkout content here
          const Text(
            'Order Summary',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.products.length,
            itemBuilder: (context, index) {
              final product = widget.products[index];
              return ListTile(
                leading: Image.network(product.image!),
                title: Text(product.title!),
                subtitle: Text('Quantity: ${product.quantity}  Total Price: ${product.price*product.quantity}'),
              );
            },
          ),
          SizedBox(height: 16),
          Text(
            'Final Price: \$${widget.totalPrice}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _integration.openSession(amount: widget.totalPrice);
              // Add your payment logic here
            },
            child: Text('Proceed to Payment'),
          ),
        ],
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   List<PayCard> paymentOptions = getPaymentOptions();

  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     appBar: buildCheckoutAppBar(context,widget.totalPrice),
  //     body: Container(
  //       padding: EdgeInsets.only(top: 0, left: 10, right: 10),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Expanded(
  //               child: ListView.builder(
  //                   itemCount: paymentOptions.length,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     return Padding(
  //                       padding: EdgeInsets.all(8.0),
  //                       child: ExpansionTile(
  //                         title: Text(
  //                           paymentOptions[index].title!,
  //                           style: TextStyle(
  //                               fontSize: 16, fontWeight: FontWeight.bold),
  //                         ),
  //                         children: [
  //                           buildPaymentList(paymentOptions, index),
  //                           buildPaymentList(paymentOptions, 3),
  //                           buildPaymentList(paymentOptions, 2),
  //                         ],
  //                       ),

  //                       //buildPaymentList(paymentOptions, index)
  //                     );
  //                   })),
  //           alignCheckoutBtnBottom(context,widget.totalPrice)
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
