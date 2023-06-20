import 'package:flutter/material.dart';
import 'package:eshop/src/components/text_widgets.dart';
import 'package:eshop/src/screens/payment/components/wallet_options_list.dart';

AppBar buildCheckoutAppBar(BuildContext context,double totalPrice) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: Text(
      'Checkout (\$ $totalPrice)',
      style: TextStyle(
        color: Colors.indigo,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: false,
    leading: backNavIcon(context),
  );
}

ListTile buildPaymentList(List<PayCard> paymentOptions, int index) {
  return ListTile(
    title: Text(
      paymentOptions[index].title!,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      paymentOptions[index].title!,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    ),
    onTap: () => print(paymentOptions[index]),
    leading: Icon(Icons.credit_card, color: Colors.blueGrey, size: 30),
    trailing: Icon(
      Icons.arrow_drop_down_sharp,
      color: Colors.blueGrey,
    ),
  );
}
