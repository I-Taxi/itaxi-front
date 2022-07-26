import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoList {
  String? id;
  String? uid;
  String? email;
  String? phone;
  String? name;
  String? bank;
  String? bankAddress;

  UserInfoList({
    this.id,
    this.uid,
    this.email,
    this.phone,
    this.name,
    this.bank,
    this.bankAddress,
  });

  UserInfoList copyWith({
    String? id,
    String? uid,
    String? email,
    String? phone,
    String? name,
    String? bank,
    String? bankAddress
  }) {
    return UserInfoList(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        name: name ?? this.name,
        bank: bank ?? this.bank,
        bankAddress: bankAddress ?? this.bankAddress
    );
  }

  factory UserInfoList.fromDocs(Map<String, dynamic> ds) {
    return UserInfoList(
        id: ds['id'],
        uid: ds['uid'],
        email: ds['email'],
        phone: ds['phone'],
        name: ds['name'],
        bank: ds['bank'],
        bankAddress: ds['bankAddress']
    );
  }

  factory UserInfoList.fromSnapshot(DocumentSnapshot ss) {
    return UserInfoList(
        id: ss.get('id'),
        uid: ss.get('uid'),
        email: ss.get('email'),
        phone: ss.get('phone'),
        name: ss.get('name'),
        bank: ss.get('bank'),
        bankAddress: ss.get('bankAddress')
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id.toString(),
      'uid': uid.toString(),
      'email': email.toString(),
      'phone': phone.toString(),
      'name': name.toString(),
      'bank': bank.toString(),
      'bankAddress': bankAddress.toString()
    };
  }
}