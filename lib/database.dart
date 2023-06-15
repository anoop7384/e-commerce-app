// This contains all the apis used in project

import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_shopping_app/src/models/products.dart';

Future<List<dynamic>> fetchAllProducts() async {
  final response = await Dio().get('https://fakestoreapi.com/products');
  if (response.statusCode == 200) {
    return parseProducts(response.data);
  }
  return [];
}

List<dynamic> parseProducts(responseBody) {
  var listProducts =
      responseBody.map((tagJson) => Product.fromJson(tagJson)).toList();
  return listProducts;
}

Future getCategories() async {
  try {
    var response =
        await Dio().get('https://fakestoreapi.com/products/categories');
    return response.data;
  } catch (e) {
    print(e);
  }
}

Future getProducts() async {
  try {
    var response = await Dio().get('https://fakestoreapi.com/products');
    final jsonData = json.decode(response.data);
    var someValue = Product.fromJson(jsonData);
    print(someValue);
    return response;
  } catch (e) {
    print(e);
  }
}

void getProductByCategory(category) async {
  try {
    var response =
        await Dio().get('https://fakestoreapi.com/products/category/$category');
    print(response);
  } catch (e) {
    print(e);
  }
}

Future getProductByLimit(limit) async {
  try {
    var response =
        await Dio().get('https://fakestoreapi.com/products?limit=$limit');
    print(response);
    return response;
  } catch (e) {
    print(e);
  }
}

void getProductById(id) async {
  try {
    var response = await Dio().get('https://fakestoreapi.com/products/$id');
    print(response);
  } catch (e) {
    print(e);
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

Future<List<Product>> getProductsByCategory(String category) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot querySnapshot = await firestore
      .collection('products')
      .where('category', isEqualTo: category)
      .get();
  if(category=="ALL"){
    querySnapshot = await firestore.collection('products').get();
  }


  List<Product> products = [];

  querySnapshot.docs.forEach((doc) {
    if (doc.exists) {
      Product product = Product.fromJson(doc.data() as Map<String, dynamic>);
      products.add(product);
    }
  });

  return products;
}