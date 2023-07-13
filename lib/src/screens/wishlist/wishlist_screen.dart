import 'package:eshop/database.dart';
import 'package:eshop/src/models/products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/text_widgets.dart';
import '../../models/products.dart';
import '../home/components/_product_grid_builder.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  List<Product> products = [];
  bool waiting = true;

  @override
  void initState() {
    fetchWishItems();
    super.initState();
  }

  void fetchWishItems() async {
    final user = FirebaseAuth.instance.currentUser;
    List<Product> Items = await getWishList(user!.uid.toString());
    setState(() {
      products = Items;
      waiting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return waiting
        ? const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.indigo,
              strokeWidth: 1,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                'Your Wishlist',
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: false,
              leading: backNavIcon(context),
            ),
            body: Column(
              children: <Widget>[
                Flexible(child: buildProductGridView(context, products))
              ],
            ),
          );
  }
}
