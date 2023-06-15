import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'components/body.dart';
import 'components/register_app_bar.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    print('deviceWidth $deviceWidth and deviceHeight $deviceHeight');
    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).isFirstFocus) {
          FocusScope.of(context).requestFocus(new FocusNode());
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: buildRegisterAppBar(context),
          body: RegisterBody()),
    );
  }
}
