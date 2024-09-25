import 'package:flutter/material.dart';

class User {
  int studentId;
  String fname;
  String mname;
  String lname;
  String email;
  String college;
  DateTime createdAt;

  User({
    required this.studentId,
    required this.fname,
    required this.mname,
    required this.lname,
    required this.email,
    required this.college,
    required this.createdAt,
  });

  // Factory method to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      studentId: json['student_id'],
      fname: json['fname'],
      mname: json['mname'],
      lname: json['lname'],
      email: json['email'],
      college: json['college'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Method to convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'fname': fname,
      'mname': mname,
      'lname': lname,
      'email': email,
      'college': college,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
