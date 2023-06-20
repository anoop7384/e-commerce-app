// import 'dart:ffi';
import 'dart:typed_data';

import 'package:eshop/src/models/userProfile.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
        ),
        body: waiting
            ? Center(
                child: CircularProgressIndicator(
                    strokeWidth: 2, backgroundColor: Colors.indigoAccent),
              )
            : Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: downloadUrl.isNotEmpty
                          ? NetworkImage(downloadUrl)
                          : null,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      profile!.username,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      profile!.email,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Address:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      profile!.address,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Phone Number:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      profile!.phoneNumber,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Date of Birth:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '${profile!.dateOfBirth.day}/${profile!.dateOfBirth.month}/${profile!.dateOfBirth.year}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () async {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => Builder(
                        //         builder: (innerContext) => const Orders(),
                        //       ),
                        //     ));
                      },
                      child: Text('My Orders'),
                    ),
                    SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Builder(
                              builder: (innerContext) => UpdateProfile(
                                  profile: profile!, downloadURL: downloadUrl),
                            ),
                          ),
                        )
                      },
                      child: Text('Update Profile'),
                    ),
                  ],
                ),
              ));
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
}
