import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:eshop/constants.dart';
import 'package:eshop/src/screens/home/home_screen.dart';
import 'package:eshop/src/screens/login/components/textfield_decoration.dart';
import 'package:eshop/src/screens/login/components/widgets.dart';
import 'package:eshop/src/screens/register/register_screen.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  dynamic email = "";
  dynamic password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(40.0),
      children: [
        buildHeroThumbnail(AssetImage('assets/images/icon.png')),
        SizedBox(height: 20),
        buildTextLoginNow(),
        SizedBox(height: 20),
        buildRowCreateNew(),
        SizedBox(height: 20),
        // emailField,
        TextField(
          controller: emailController,
          onChanged: (value) => email = value,
          textCapitalization: TextCapitalization.words,
          style: TextStyle(color: Colors.blue),
          cursorColor: Colors.blue,
          keyboardType: TextInputType.emailAddress,
          decoration: fieldDecoration(
            Icon(CupertinoIcons.mail_solid),
            'Phone, email or username',
          ),
        ),
        SizedBox(height: 20),
        // passwordField
        TextField(
          controller: passwordController,
          onChanged: (value) => password = value,
          textCapitalization: TextCapitalization.words,
          style: TextStyle(color: Colors.blue),
          autofocus: false,
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          cursorColor: Colors.blue,
          decoration:
          fieldDecoration(Icon(CupertinoIcons.lock_fill), 'Password'),
        ),
        SizedBox(height: 40),
        // buildRowForgotPassword()
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account? ",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                )),
            TextButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterScreen()),
                  )
                },
                child: const Text("Register"))
          ],
        ),
        SizedBox(height: 10),
        // buildLoginButton()
        ElevatedButton(
            onPressed: () async {
              try {
                final credential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                    email: email, password: password);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  if (kDebugMode) {
                    print('no user');
                  }
                } else if (e.code == 'wrong password') {
                  if (kDebugMode) {
                    print('wrong password');
                  }
                }
              } catch (err) {
                if (kDebugMode) {
                  print(err);
                }
              }
            },
            style: ElevatedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(8.0),
              ),
            ),
            child: Container(
                padding: EdgeInsets.all(12),
                width: double.infinity,
                child: Center(
                    child: Text("Login",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ))))),
      ],
    );
  }
}


