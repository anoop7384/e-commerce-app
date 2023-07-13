import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/database.dart';
import 'package:eshop/src/models/cartItems.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eshop/constants.dart';
import 'package:eshop/src/models/products.dart';
import 'package:eshop/src/screens/cart/cart_screen.dart';
import 'package:eshop/src/screens/payment/summary/order_summary_screen.dart';

Container imageContainer(double imageHeight, Product product) {
  return Container(
    height: imageHeight,
    child: Hero(tag: product.id!, child: Image.network(product.image!)),
  );
}

Row thumbnailImages(product) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      clipImageRect(product.image),
      const SizedBox(width: 10),
      clipImageRect(product.image),
      const SizedBox(width: 10),
      clipImageRect(product.image),
    ],
  );
}

Row buildThumbnailRow(product) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      clipImageRect(product.image),
      const SizedBox(width: 10),
      clipImageRect(product.image),
      const SizedBox(width: 10),
      clipImageRect(product.image),
      const Spacer(),
      rowRating()
    ],
  );
}

Row rowRating() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        Icons.star,
        color: Colors.amber,
        size: 20,
      ),
      SizedBox(width: 4),
      Text('4.7', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
    ],
  );
}

Column buildRowBtnPrice(context, Product product) {
  return Column(
    children: [
      Text(
        '\$ ${product.price}',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.white),
      ),
      const SizedBox(height: 20,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
              onPressed: () async {
                await addToCart(
                    FirebaseAuth.instance.currentUser!.uid.toString(), product);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text('ADD TO CART', style: TextStyle(fontSize: 20))),
          ElevatedButton(
              onPressed: () {
                CartItem toCart = CartItem(
                  id: product.id,
                  title: product.title,
                  description: product.description,
                  category: product.category,
                  image: product.image,
                  quantity: 1,
                  price: product.price,
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderSummary(
                            products: [toCart], totalPrice: product.price)));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text('BUY NOW', style: TextStyle(fontSize: 20))),
        ],
      ),
    ],
  );
}

CircleAvatar buildCircleColorAvatar(Color color) {
  return CircleAvatar(
    backgroundColor: color,
    radius: sDefaultColorPadding,
  );
}

BoxDecoration boxDecoration() {
  return BoxDecoration(
    color: Colors.blueGrey,
    border: Border.all(
      color: Colors.grey.shade300,
    ),
    borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30), topRight: Radius.circular(30)),
  );
}

ClipRRect clipImageRect(image) {
  return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      child: Image.network(image, height: 50, width: 50));
}
