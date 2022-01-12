import 'dart:convert';

import 'package:flutter/material.dart';

class UserModel {
  String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final String profileImage;

  UserModel({
    this.uid = '',
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.profileImage,
  });

  Map<String, dynamic> toJSON() => {
        'uid': uid,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'role': role,
        'profileImage': profileImage,
      };

  static UserModel fromJSON(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        email: json['email'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        role: json['lastName'],
        profileImage: json['profileImage'],
      );
}
