import 'package:eshop/src/screens/profile/profile.dart';
import 'package:eshop/src/screens/wishlist/wishlist_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../cart/cart_screen.dart';
import '../../login/login_screen.dart';
import '../../notification/notification.dart';

AppBar homeActionBar(context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset('assets/images/icon.png',
      height: 40,
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My E-Shop',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          // Text(
          //   'A few clicks is all it takes.',
          //   style: TextStyle(
          //       fontSize: 12,
          //       fontWeight: FontWeight.normal,
          //       color: Colors.indigo),
          // )
        ],
      ),
    ),
    centerTitle: false,
    actions: [
      // Padding(
      //     padding: const EdgeInsets.all(8),
      //     child: InkWell(
      //       onTap: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => NotificationScreen()),
      //         );
      //       },
      //       child:
      //           const Icon(CupertinoIcons.bell, size: 30, color: Colors.blue),
      //     )),
      Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WishList()),
              );
            },
            child:
                const Icon(CupertinoIcons.heart, size: 30, color: Colors.blue),
          )),
      Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductCart()),
              );
            },
            child:
                const Icon(CupertinoIcons.cart, size: 30, color: Colors.blue),
          )),
      Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
            child:
                const Icon(CupertinoIcons.person, size: 30, color: Colors.blue),
          )),
      //Icon(CupertinoIcons.search, size: 30, color: Colors.indigoAccent)
    ],
  );
}
