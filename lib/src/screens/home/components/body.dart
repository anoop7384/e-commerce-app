import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eshop/src/components/search_box.dart';
import 'package:eshop/src/screens/home/components/_product_category.dart';
import 'package:eshop/src/screens/home/components/_product_grid_builder.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
    @required this.categories,
    @required this.products,
    @required this.selectedIndex,
  }) : super(key: key);

  final List? categories;
  final List? products;
  final int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(onPressed: () async {addProductsToFirestore(products);},
            child: Text("Add to database")),
        SearchBox(onChanged: (value) {
          print('Searching for..$value');
        }),
        Categories(categories: categories),
        Flexible(child: buildProductGridView(context, products!))
      ],
    );
  }

  void addProductsToFirestore(List? apiProductList) {
    // Example API product list
    // List<Product> apiProductList = [...];

    // Initialize Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Add each product to Firestore
    apiProductList?.forEach((product) {
      firestore
          .collection('products')
          .add(product)
          .then((value) {
        print('Product added to Firestore successfully!');
      }).catchError((error) {
        print('Failed to add product to Firestore: $error');
      });
    });
  }
}


