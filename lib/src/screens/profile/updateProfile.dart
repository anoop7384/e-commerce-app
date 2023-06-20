import 'dart:io';
import 'dart:math';

import 'package:eshop/src/screens/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../database.dart';
import '../../models/userProfile.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile(
      {Key? key, required this.profile, required this.downloadURL})
      : super(key: key);
  final UserProfile profile;
  final String downloadURL;

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String picture = "";
  UserProfile? userProfile;
  File? imageFile;
  bool waiting = false;

  @override
  void initState() {
    picture = widget.downloadURL;
    userProfile = widget.profile;
    super.initState();
  }

  Future<void> selectProfilePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      imageFile = File(pickedImage.path);

      setState(() {
        picture = imageFile!.path;
      });
    }
  }

  Future<void> updateProfile() async {
    setState(() {
      waiting = true;
    });
    String userId = FirebaseAuth.instance.currentUser!.uid.toString();
    await updateUser(userId, userProfile!);
    if (imageFile != null) {
      String downloadUrl = await uploadProfilePicture(imageFile!, userId);
      print('Profile picture uploaded. Download URL: $downloadUrl');
    }

    print('Updated Profile:');
    print('Username: ${userProfile!.username}');
    print('Email: ${userProfile!.email}');
    print('Address: ${userProfile!.address}');
    print('Phone Number: ${userProfile!.phoneNumber}');
    print('Date of Birth: ${userProfile!.dateOfBirth}');
    setState(() {
      waiting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: waiting
          ? Center(
              child: CircularProgressIndicator(
                  strokeWidth: 2, backgroundColor: Colors.indigoAccent),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Profile Picture'),
                  SizedBox(height: 8.0),
                  imageFile == null
                      ? CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(picture),
                        )
                      : CircleAvatar(
                          radius: 50.0,
                          child: ClipOval(
                            child: Image.file(
                              imageFile!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () async {
                      await selectProfilePicture();
                    },
                    child: Text('Select Profile Picture'),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: widget.profile.username,
                    onChanged: (value) {
                      setState(() {
                        userProfile = userProfile!.copyWith(username: value);
                      });
                    },
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: widget.profile.address,
                    onChanged: (value) {
                      setState(() {
                        userProfile = userProfile!.copyWith(address: value);
                      });
                    },
                    decoration: InputDecoration(labelText: 'Address'),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: widget.profile.phoneNumber,
                    onChanged: (value) {
                      setState(() {
                        userProfile = userProfile!.copyWith(phoneNumber: value);
                      });
                    },
                    decoration: InputDecoration(labelText: 'Phone Number'),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      updateProfile();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Builder(
                              builder: (innerContext) => const Profile(),
                            ),
                          ));
                      // Navigator.pop(context);
                    },
                    child: Text('Update Profile'),
                  ),
                ],
              ),
            ),
    );
  }
}
