import 'package:eshop/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eshop/src/components/text_widgets.dart';

AppBar detailAppBar(context, bool isWished) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    leading: backNavIcon(context),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: isWished
            ? InkWell(
                onTap: () {
                  // Add your onTap logic here
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
  );
}
