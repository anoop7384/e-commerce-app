import 'package:flutter/material.dart';
import 'package:eshop/src/screens/payment/summary/order_summary_screen.dart';

import '../../../models/cartItems.dart';

Align buildAlignBtnBottom(
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
              Text(
                'Total',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '\$ $finalPrice',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )
            ],
          ),
          Spacer(),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderSummary(
                            products: cartItems, totalPrice: finalPrice)));
              },
              style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
              child: Text('Checkout', style: TextStyle(fontSize: 20)))
        ],
      ),
    ),
  );
}
