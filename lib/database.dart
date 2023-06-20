// This contains all the apis used in project

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:eshop/src/models/cartItems.dart';
import 'package:eshop/src/models/products.dart';
import 'package:eshop/src/models/userProfile.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> createUser(UserProfile user, String userId) async {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  try {
    await usersCollection.doc(userId).set(user.toJson());
    print('User created successfully');
  } catch (e) {
    print('Failed to create user: $e');
  }
}

Future<void> updateUser(String userId, UserProfile updatedUser) async {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  try {
    await usersCollection.doc(userId).update(updatedUser.toJson());
    print('User updated successfully');
  } catch (e) {
    print('Failed to update user: $e');
  }
}

Future<Map<String, dynamic>?> getUserProfile(String userId) async {
  final DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();

  if (snapshot.exists) {
    return snapshot.data() as Map<String, dynamic>?;
  } else {
    return null;
  }
}

Future<String> uploadProfilePicture(File imageFile, String userId) async {
  final Reference storageReference = FirebaseStorage.instance
      .ref()
      .child('profile_pictures/$userId/profile_pic_$userId.jpg');
  await storageReference.putFile(imageFile);
  final String downloadUrl = await storageReference.getDownloadURL();
  return downloadUrl;
}

Future<String> getProfilePictureUrl(String userId) async {
  try {
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('profile_pictures/$userId/profile_pic_$userId.jpg');
    final String downloadUrl = await storageReference.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    return "";
  }
}

Future<List<Product>> getDbProducts() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot querySnapshot = await firestore.collection('products').get();

  List<Product> products = [];

  querySnapshot.docs.forEach((doc) {
    if (doc.exists) {
      Product product = Product.fromJson(doc.data() as Map<String, dynamic>);
      products.add(product);
    }
  });

  return products;
}

Future<List<String>> getCategory() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot querySnapshot =
      await firestore.collection('categories').orderBy('category').get();

  List<String> products = [];

  querySnapshot.docs.forEach((doc) {
    if (doc.exists) {
      var cat = doc.data() as Map<String, dynamic>;
      products.add(cat['category'].toString());
    }
  });

  print(products);

  return products;
}

Future<void> addToCart(String userId, Product product) async {
  try {
    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart');

    await cartRef.doc(product.id.toString()).set(product.toJson());

    print('Product added to cart successfully!');
  } catch (error) {
    print('Failed to add product to cart: $error');
  }
}

Future<List<CartItem>> getCart(String userId) async {
  final cartRef = FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
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

  return Items;
}


Future<void> addToWishList(String userId, Product product) async {
  try {
    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('wishlist');

    await cartRef.doc(product.id.toString()).set(product.toJson());

    print('Product added to wishlist successfully!');
  } catch (error) {
    print('Failed to add product to wishlist: $error');
  }
}

Future<void> removeFromWishList(String userId, String productId) async {
  try {
    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('wishlist');

    await cartRef.doc(productId).delete();

    print('Product removed from wishlist successfully!');
  } catch (error) {
    print('Failed to remove product from wishlist: $error');
  }
}


Future<List<Product>> getWishList(String userId) async {
  final cartRef = FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('wishlist');

  QuerySnapshot querySnapshot = await cartRef.get();
  List<Product> Items = [];

  querySnapshot.docs.forEach((doc) {
    Product cartItem = Product(
      id: doc['id'],
      title: doc['title'],
      description: doc['description'],
      category: doc['category'],
      image: doc['image'],
      price: doc['price'],
    );

    Items.add(cartItem);
  });

  return Items;
}

Future<bool> isProductInWishList(String userId, String productId) async {
  try {
    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('wishlist');

    final snapshot = await cartRef.doc(productId).get();

    return snapshot.exists;
  } catch (error) {
    print('Error checking product in wishlist: $error');
    return false;
  }
}
