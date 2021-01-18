import 'package:flutter/material.dart';
import 'package:pos_app/models/addresses.dart';
import 'package:pos_app/models/phones.dart';

class User {
  final int id;
  final int accSerial;
  final String name;
  final String email;
  final String password;
  List phones;
  final String token;
  final TimeOfDay createdAt;
  final List<Addresses> address;

  User(
      {this.accSerial,
      this.id,
      this.name,
      this.email,
      this.password,
      this.phones,
      this.token,
      this.createdAt,
      this.address});

  factory User.fromJson(data) {
    return User(
      accSerial: data['AccSerial'],
      id: data['id'],
      name: data['name'],
      email: data['username'],
      password: data['password'],
      createdAt: data['created_at'],
      phones: data['phones'],
      address: data['addresses'],
      token: data['token'],
    );
  }
}
