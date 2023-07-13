import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

InputDecoration fieldDecoration(Icon icon, String fieldText) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color: Colors.grey.shade100, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
      borderSide: BorderSide(color: Colors.grey.shade100),
    ),
    alignLabelWithHint: true,
    fillColor: Colors.grey.shade100,
    filled: true,
    hintText: fieldText,
    hintStyle: TextStyle(color: Colors.blue),
    prefixIcon: icon,
  );
}

final emailField = TextField(
  textCapitalization: TextCapitalization.words,
  style: TextStyle(color: Colors.blue),
  cursorColor: Colors.blue,
  keyboardType: TextInputType.emailAddress,
  decoration: fieldDecoration(
    Icon(CupertinoIcons.mail_solid),
    'Phone, email or username',
  ),
);

final passwordField = TextField(
  textCapitalization: TextCapitalization.words,
  style: TextStyle(color: Colors.blue),
  autofocus: false,
  obscureText: true,
  keyboardType: TextInputType.visiblePassword,
  cursorColor: Colors.blue,
  decoration: fieldDecoration(Icon(CupertinoIcons.lock_fill), 'Password'),
);
