import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/src/screens/reciept/reciept_page.dart';

Align alignCheckoutBtnBottom(BuildContext context,double totalPrice) {
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
                '\$ $totalPrice',
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReceiptPage()));
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
