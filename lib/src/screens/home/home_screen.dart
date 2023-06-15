import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_shopping_app/database.dart';

import '../../../constants.dart';
import '../../components/search_box.dart';
import '../../models/products.dart';
import 'components/_action_bar.dart';
import 'components/_product_category.dart';
import 'components/_product_grid_builder.dart';
import 'components/body.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var fakeProducts = [];
  var products = [];
  List categories = [];
  var subscription;
  var selectedIndex = 0;

  @override
  void initState() {
    getDbProducts().then((items) async {
      setState(() {
        products = items;
      });
    });
    getCategories().then((items) async {
      setState(() {
        categories = items;
        categories.insert(0, "ALL");
      });
      _loadData();
    });

    super.initState();
  }

  void _loadData() async {
    setState(() {
      fakeProducts = products
          .where((product) =>
          (selectedIndex==0 || product.category == categories[selectedIndex]))
          .toList();
    });
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: null,
      backgroundColor: Colors.white,
      appBar: homeActionBar(context),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: fakeProducts.length == 0
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.indigo,
                  strokeWidth: 1,
                ),
              )
            : Column(
                children: <Widget>[

                  SearchBox(onChanged: (value) {
                    print('Searching for..$value');
                    searchProducts(value);
                  }),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: SizedBox(
                      height: 28,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) => buildCategory(index),
                      ),
                    ),
                  ),

                  Flexible(child: buildProductGridView(context, fakeProducts))
                ],
              ),
      ),
    );
  }

  void searchProducts(String searchText) {
    if (searchText.isEmpty) {
      setState(() {
        fakeProducts = products; // Reset to show all products
      });
    } else {
      setState(() {
        fakeProducts = products
            .where((product) =>
            product.title.toLowerCase().contains(searchText.toLowerCase()))
            .toList();
      });
    }
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        _loadData();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                wordSpacing: 1,
                color: selectedIndex == index ? Colors.indigo : kTextLightColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0 / 4), //top padding 5
              height: 2,
              width: 40,
              color: selectedIndex == index ? Colors.indigo : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
