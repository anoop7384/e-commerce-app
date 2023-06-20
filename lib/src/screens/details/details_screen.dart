import 'package:eshop/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/text_widgets.dart';
import '../../models/products.dart';
import 'components/body.dart';
import 'components/detail_app_bar.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key, this.product}) : super(key: key);
  final Product? product;
  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isWished = false;
  bool waiting = true;
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    check();
    super.initState();
  }

  Future<void> check() async {
    if (await isProductInWishList(user!.uid, widget.product!.id.toString())) {
      setState(() {
        isWished = true;
      });
    }
    setState(() {
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
              elevation: 0,
              backgroundColor: Colors.white,
              leading: backNavIcon(context),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: isWished
                      ? InkWell(
                          onTap: () {
                            removeFromWishList(user!.uid.toString(),
                                widget.product!.id.toString());
                            setState(() {
                              isWished = false;
                            });
                          },
                          child: CircleAvatar(
                              backgroundColor: Colors.grey.shade300,
                              child: Icon(
                                CupertinoIcons.heart_fill,
                                color: Colors.red.shade300,
                                size: 30,
                              )))
                      : InkWell(
                          onTap: () {
                            addToWishList(
                                user!.uid.toString(), widget.product!);
                            setState(() {
                              isWished = true;
                            });
                          },
                          child: CircleAvatar(
                              backgroundColor: Colors.grey.shade300,
                              child: const Icon(
                                CupertinoIcons.heart_fill,
                                color: Color.fromARGB(255, 122, 121, 121),
                                size: 30,
                              ))),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            body: DetailBody(product: widget.product!));
  }
}
