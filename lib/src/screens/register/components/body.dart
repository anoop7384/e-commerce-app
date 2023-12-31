import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:eshop/constants.dart';
import 'package:eshop/src/screens/Register/components/textfield_decoration.dart';
import 'package:eshop/src/screens/login/login_screen.dart';
import 'package:eshop/src/screens/register/components/widgets.dart';

import '../../../../database.dart';
import '../../../models/userProfile.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({Key? key}) : super(key: key);

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  dynamic email = "";
  dynamic fullname = "";
  dynamic password = "";
  dynamic phonenumber = "";
  final fullnameController = TextEditingController();
  final phonenumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(40.0),
      children: [
        buildHeroThumbnail(const AssetImage('assets/images/icon.png')),
        const SizedBox(height: 20),
        buildTextRegisterNow(),
        const SizedBox(height: 20),
        buildRowCreateNew(),
        const SizedBox(height: 20),
        // emailField,
        TextField(
          controller: fullnameController,
          onChanged: (value) => fullname = value,
          textCapitalization: TextCapitalization.words,
          style: const TextStyle(color: Colors.blue),
          cursorColor: Colors.blue,
          keyboardType: TextInputType.emailAddress,
          decoration: fieldDecoration(
            const Icon(CupertinoIcons.person),
            'Full Name',
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: emailController,
          onChanged: (value) => email = value,
          textCapitalization: TextCapitalization.words,
          style: const TextStyle(color: Colors.blue),
          cursorColor: Colors.blue,
          keyboardType: TextInputType.emailAddress,
          decoration: fieldDecoration(
            const Icon(CupertinoIcons.mail_solid),
            'Email',
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: phonenumberController,
          onChanged: (value) => phonenumber = value,
          textCapitalization: TextCapitalization.words,
          style: const TextStyle(color: Colors.blue),
          cursorColor: Colors.blue,
          keyboardType: TextInputType.emailAddress,
          decoration: fieldDecoration(
            const Icon(CupertinoIcons.phone),
            'Phone Number',
          ),
        ),
        const SizedBox(height: 20),
        // passwordField
        TextField(
          controller: passwordController,
          onChanged: (value) => password = value,
          textCapitalization: TextCapitalization.words,
          style: const TextStyle(color: Colors.blue),
          autofocus: false,
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          cursorColor: Colors.blue,
          decoration:
              fieldDecoration(const Icon(CupertinoIcons.lock_fill), 'Password'),
        ),
        const SizedBox(height: 40),
        // buildRowForgotPassword()
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account ",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                )),
                TextButton(
                  onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                )
              },
                child: const Text(
                'Sign In.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
            
          ],
        ),
        const SizedBox(height: 10),
        // buildRegisterButton()
        ElevatedButton(
            onPressed: () async {
              try {
                final credential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: email, password: password);
                final user = FirebaseAuth.instance.currentUser;
                UserProfile userProfile = UserProfile(
                  username: fullname,
                  email: email,
                  address: '',
                  phoneNumber: phonenumber,
                  dateOfBirth: DateTime(1999, 1, 1),
                );
                createUser(userProfile, user!.uid.toString());
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  if (kDebugMode) {
                    print('Weak Password');
                  }
                } else if (e.code == 'email-already-in-use') {
                  if (kDebugMode) {
                    print('Account exists');
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
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                child: const Center(
                    child: Text("Register",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ))))),
      ],
    );
  }
}
