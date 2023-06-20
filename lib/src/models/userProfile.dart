import 'package:flutter/material.dart';

class UserProfile {
  final String username;
  final String email;
  final String address;
  final String phoneNumber;
  final DateTime dateOfBirth;

  UserProfile({
    required this.username,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.dateOfBirth,
  });

  UserProfile copyWith({
    String? username,
    String? email,
    String? address,
    String? phoneNumber,
    DateTime? dateOfBirth,
  }) {
    return UserProfile(
      username: username ?? this.username,
      email: email ?? this.email,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'address': address,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth.toIso8601String(),
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'],
      email: json['email'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
    );
  }
}
