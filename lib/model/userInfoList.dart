import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoList {
  String? bankAddress;
  String? bank;
  String? phone;
  String? email;
  String? uid;
  String? name;
  int? id;

  UserInfoList({
    this.bankAddress,
    this.bank,
    this.phone,
    this.email,
    this.uid,
    this.name,
    this.id,
  });

  UserInfoList copyWith({
    String? bankAddress,
    String? bank,
    String? phone,
    String? email,
    String? uid,
    String? name,
    int? id
  }) {
    return UserInfoList(
      bankAddress: bankAddress ?? this.bankAddress,
      bank: bank ?? this.bank,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      id: id ?? this.id

    );
  }

  factory UserInfoList.fromDocs(Map<String, dynamic> ds) {
    return UserInfoList(
      bankAddress: ds['bankAddress'],
      bank: ds['bank'],
      phone: ds['phone'],
      email: ds['email'],
      uid: ds['uid'],
      name: ds['name'],
      id: ds['id'],

    );
  }

  factory UserInfoList.fromSnapshot(DocumentSnapshot ss) {
    return UserInfoList(
      bankAddress: ss.get('bankAddress'),
      bank: ss.get('bank'),
      phone: ss.get('phone'),
      email: ss.get('email'),
      uid: ss.get('uid'),
      name: ss.get('name'),
      id: ss.get('id'),

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bankAddress': bankAddress,
      'bank': bank,
      'phone': phone,
      'email': email,
      'uid': uid,
      'name': name,
      'id': id,
    };
  }
}