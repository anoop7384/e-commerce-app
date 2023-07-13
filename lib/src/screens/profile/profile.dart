// import 'dart:ffi';
import 'dart:typed_data';

import 'package:eshop/src/models/userProfile.dart';
import 'package:eshop/src/screens/login/login_screen.dart';
import 'package:eshop/src/screens/orders/order_screen.dart';
import 'package:eshop/src/screens/profile/profilePic.dart';
import 'package:eshop/src/screens/profile/updateProfile.dart';
import 'package:eshop/src/screens/wishlist/wishlist_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../database.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserProfile? profile;
  String downloadUrl = "";
  bool waiting = true;

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  Future<void> getProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic>? data = await getUserProfile(user!.uid.toString());
    // print(data);
    String path = await getProfilePictureUrl(user.uid.toString());

    setState(() {
      profile = UserProfile.fromJson(data!);
      downloadUrl = path;
      waiting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: waiting
          ? const Center(
              child: CircularProgressIndicator(
                  strokeWidth: 2, backgroundColor: Colors.indigoAccent),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    // navigateSecondPage(EditImagePage());
                  },
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: downloadUrl.isNotEmpty
                        ? NetworkImage(downloadUrl)
                        : null,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(children: [
                    buildUserInfoDisplay(profile!.username, 'Name'),
                    buildUserInfoDisplay(profile!.email, 'E-mail'),
                    buildUserInfoDisplay(profile!.phoneNumber, 'Contact'),
                    buildUserInfoDisplay(
                        '${profile!.dateOfBirth.day}/${profile!.dateOfBirth.month}/${profile!.dateOfBirth.year}',
                        'D.O.B'),
                    buildUserInfoDisplay(profile!.address, 'Address'),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Builder(
                                  builder: (innerContext) =>
                                      const OrderScreen(),
                                ),
                              ),
                            )
                          },
                          child: const Text('My Orders'),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Builder(
                                  builder: (innerContext) => UpdateProfile(
                                      profile: profile!,
                                      downloadURL: downloadUrl),
                                ),
                              ),
                            )
                          },
                          child: const Text('Update Profile'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final FirebaseAuth _firebaseAuth =
                                FirebaseAuth.instance;
                            await _firebaseAuth.signOut();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Builder(
                                    builder: (innerContext) => LoginScreen()),
                              ),
                            );
                          },
                          child: const Text('Log out'),
                        ),
                      ],
                    ),
                  ]),
                ),
              ],
            ),
    );

    // return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('User Profile'),
    //     ),
    //     body: waiting
    //         ? const Center(
    //             child: CircularProgressIndicator(
    //                 strokeWidth: 2, backgroundColor: Colors.indigoAccent),
    //           )
    //         : Container(
    //             padding: const EdgeInsets.all(16.0),
    //             child: Column(
    //               children: [
    //                 CircleAvatar(
    //                   radius: 50.0,
    //                   backgroundImage: downloadUrl.isNotEmpty
    //                       ? NetworkImage(downloadUrl)
    //                       : null,
    //                 ),
    //                 const SizedBox(height: 16.0),
    //                 Text(
    //                   profile!.username,
    //                   style: const TextStyle(
    //                     fontSize: 24.0,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 const SizedBox(height: 8.0),
    //                 Text(
    //                   profile!.email,
    //                   style: const TextStyle(
    //                     fontSize: 16.0,
    //                     color: Colors.grey,
    //                   ),
    //                 ),
    //                 const SizedBox(height: 16.0),
    //                 const Text(
    //                   'Address:',
    //                   style: TextStyle(
    //                     fontSize: 18.0,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 const SizedBox(height: 8.0),
    //                 Text(
    //                   profile!.address,
    //                   style: const TextStyle(
    //                     fontSize: 16.0,
    //                     color: Colors.grey,
    //                   ),
    //                 ),
    //                 const SizedBox(height: 16.0),
    //                 const Text(
    //                   'Phone Number:',
    //                   style: TextStyle(
    //                     fontSize: 18.0,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 const SizedBox(height: 8.0),
    //                 Text(
    //                   profile!.phoneNumber,
    //                   style: const TextStyle(
    //                     fontSize: 16.0,
    //                     color: Colors.grey,
    //                   ),
    //                 ),
    //                 const SizedBox(height: 16.0),
    //                 const Text(
    //                   'Date of Birth:',
    //                   style: TextStyle(
    //                     fontSize: 18.0,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 const SizedBox(height: 8.0),
    //                 Text(
    //                   '${profile!.dateOfBirth.day}/${profile!.dateOfBirth.month}/${profile!.dateOfBirth.year}',
    //                   style: const TextStyle(
    //                     fontSize: 16.0,
    //                     color: Colors.grey,
    //                   ),
    //                 ),
    //                 // const SizedBox(height: 8.0),
    //                 // ElevatedButton(
    //                 //   onPressed: () async {
    //                 //     // Navigator.push(
    //                 //     //     context,
    //                 //     //     MaterialPageRoute(
    //                 //     //       builder: (context) => Builder(
    //                 //     //         builder: (innerContext) => const Orders(),
    //                 //     //       ),
    //                 //     //     ));
    //                 //   },
    //                 //   child: const Text('My Orders'),
    //                 // ),
    //                 const SizedBox(height: 8.0),
    //                 ElevatedButton(
    //                   onPressed: () => {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) => Builder(
    //                           builder: (innerContext) => UpdateProfile(
    //                               profile: profile!, downloadURL: downloadUrl),
    //                         ),
    //                       ),
    //                     )
    //                   },
    //                   child: const Text('Update Profile'),
    //                 ),
    //               ],
    //             ),
    //           ));
  }

  Widget buildUserInfoDisplay(String getValue, String title) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Container(
              width: 350,
              height: 40,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          // navigateSecondPage(editPage);
                        },
                        child: Text(
                          getValue,
                          style: const TextStyle(fontSize: 16, height: 1.4),
                        ))),
              ]))
        ],
      ));

  //
}
