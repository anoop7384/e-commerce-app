import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/src/screens/cart/components/btn_bottom.dart';

import '../../../../database.dart';
import '../../../models/cartItems.dart';
import 'banner_container.dart';

class CartBody extends StatefulWidget {
  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  List<CartItem> cartItems = [];
  double finalPrice=0.0;

  @override
  void initState() {
    fetchCartItems();
    getfinalPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return cartItems.length == 0
        ? Center(
            child: CircularProgressIndicator(
                strokeWidth: 2, backgroundColor: Colors.indigoAccent),
          )
        : Container(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  buildBannerContainer(),
                  SizedBox(height: 20),
                  Expanded(
                      child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (BuildContext ctxt, int index) =>
                              buildBody(ctxt, index))),
                  buildAlignBtnBottom(context,finalPrice),
                ],
              ),
            ),
          );
  }

  buildBody(BuildContext ctxt, int index) {
    // int _itemCount = 1;
    return Card(
      child: Center(
        child: Container(
            height: 70,
            //color: Colors.indigo.shade100,
            child: ListTile(
              title: Text(
                cartItems[index].title!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              leading: Image.network(
                cartItems[index].image!,
                height: double.infinity,
                width: 60,
              ),
              subtitle: Text(
                '\$ ${cartItems[index].price}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade100,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
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
                            child: Icon(CupertinoIcons.plus_circle),
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
                            child: Icon(CupertinoIcons.minus_circle),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                          onPressed: () async {
                            final user = FirebaseAuth.instance.currentUser;
                            final cartRef = FirebaseFirestore.instance.collection('users').doc(user!.uid).collection('cart');
                            try {
                              await cartRef.doc(cartItems[index].id.toString()).delete();
                              print('Cart item removed successfully from the database.');

                              // Remove the cart item from the cartItems list
                              setState(() {
                                cartItems.remove(cartItems[index]);
                              });
                              getfinalPrice();

                              print('Cart item removed successfully from the list.');
                            } catch (error) {
                              print('Failed to remove cart item: $error');
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text('REMOVE', style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void fetchCartItems() async {
    final user = FirebaseAuth.instance.currentUser;
    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('cart');

    QuerySnapshot querySnapshot = await cartRef.get();
    List<CartItem> Items = [];

    querySnapshot.docs.forEach((doc) {
      CartItem cartItem = CartItem(
        id: doc['id'],
        title: doc['title'],
        description: doc['description'],
        category: doc['category'],
        image: doc['image'],
        quantity: 1,
        price: doc['price'],
      );

      Items.add(cartItem);
    });
    setState(() {
      cartItems = Items;
    });
    getfinalPrice();
  }

  void getfinalPrice() async {
    double sum=0.0;
    for (var cartItem in cartItems) {
      sum += (cartItem.price * cartItem.quantity);
    }
    setState(() {
      finalPrice=sum;
    });

  }
}
