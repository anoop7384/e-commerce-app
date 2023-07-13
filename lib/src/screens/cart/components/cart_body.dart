import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eshop/src/screens/cart/components/btn_bottom.dart';

import '../../../../database.dart';
import '../../../components/text_widgets.dart';
import '../../../models/cartItems.dart';
import 'banner_container.dart';

class CartBody extends StatefulWidget {
  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  List<CartItem> cartItems = [];
  double finalPrice = 0.0;

  @override
  void initState() {
    fetchCartItems();
    getfinalPrice();
    super.initState();
  }

  void fetchCartItems() async {
    final user = FirebaseAuth.instance.currentUser;
    List<CartItem> Items = await getCart(user!.uid.toString());
    setState(() {
      cartItems = Items;
    });
    getfinalPrice();
  }

  void getfinalPrice() async {
    double sum = 0.0;
    for (var cartItem in cartItems) {
      sum += (cartItem.price * cartItem.quantity);
    }
    setState(() {
      finalPrice = sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildCartAppBar(context),
        body: cartItems.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                    strokeWidth: 2, backgroundColor: Colors.indigoAccent),
              )
            : Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Expanded(
                        child: ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (BuildContext ctxt, int index) =>
                                buildBody(ctxt, index))),
                    buildAlignBtnBottom(context, cartItems, finalPrice),
                  ],
                ),
              ));
  }

  buildBody(BuildContext ctxt, int index) {
    // int _itemCount = 1;
    return Card(
      child: Center(
        child: Container(
            height: 100,
            //color: Colors.indigo.shade100,
            child: ListTile(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                  children: [
                    Flexible(
                      child: RichText(
                        overflow: TextOverflow
                            .ellipsis, // this will help add dots after maxLines
                        maxLines: 1, 
                        strutStyle: const StrutStyle(fontSize: 12.0),
                        text: TextSpan(
                            style: const TextStyle(color: Colors.black),
                            text: cartItems[index].title),
                      ),
                    ),
                  ],
                ),
                Text(
                  'SubTotal : \$ ${cartItems[index].price * cartItems[index].quantity}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade100,
                        shape: BoxShape.rectangle,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                print(cartItems[index].quantity);
                                setState(() {
                                  cartItems[index].quantity =
                                      (cartItems[index].quantity! + 1);
                                });
                                getfinalPrice();
                              },
                              child: const Icon(CupertinoIcons.plus_circle),
                            ),
                            Text(cartItems[index].quantity.toString()),
                            InkWell(
                              onTap: () {
                                print(cartItems[index].quantity);
                                setState(() {
                                  if (cartItems[index].quantity != 1) {
                                    cartItems[index].quantity =
                                        (cartItems[index].quantity! - 1);
                                  }
                                });
                                getfinalPrice();
                              },
                              child: const Icon(CupertinoIcons.minus_circle),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () async {
                        final user = FirebaseAuth.instance.currentUser;
                        final cartRef = FirebaseFirestore.instance
                            .collection('users')
                            .doc(user!.uid)
                            .collection('cart');
                        try {
                          await cartRef
                              .doc(cartItems[index].id.toString())
                              .delete();
                          print(
                              'Cart item removed successfully from the database.');

                          // Remove the cart item from the cartItems list
                          setState(() {
                            cartItems.remove(cartItems[index]);
                          });
                          getfinalPrice();

                          print(
                              'Cart item removed successfully from the list.');
                        } catch (error) {
                          print('Failed to remove cart item: $error');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      child:
                          const Text('REMOVE', style: TextStyle(fontSize: 10)),
                    ),
                  ],
                ),
              ]),
              leading: Image.network(
                cartItems[index].image!,
                height: double.infinity,
                width: 60,
              ),
              // subtitle: Text(
              //   '\$ ${cartItems[index].price}',
              //   style: const TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 16,
              //   ),
              // ),
            )),
      ),
    );
  }

  buildCartAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        'Your Cart (${cartItems.length} items)',
        style: const TextStyle(
          color: Colors.indigo,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: false,
      leading: backNavIcon(context),
    );
  }
}
