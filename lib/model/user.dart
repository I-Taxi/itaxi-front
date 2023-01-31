import 'package:cloud_firestore/cloud_firestore.dart';

class Login {
  String? uid;
  String? email;
  String? phone;
  String? name;
  String? bank;
  String? bankAddress;
  String? bankOwner;

  Login({
    this.uid,
    this.email,
    this.phone,
    this.name,
    this.bank,
    this.bankAddress,
    this.bankOwner,
  });

  Login copyWith(
      {String? uid,
      String? email,
      String? phone,
      String? name,
      String? bank,
      String? bankAddress,
      String? bankOwner,
    }) {
    return Login(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        name: name ?? this.name,
        bank: bank ?? this.bank,
        bankAddress: bankAddress ?? this.bankAddress,
        bankOwner: bankOwner ?? this.bankOwner,
      );
  }

  factory Login.fromDocs(Map<String, String> ds) {
    return Login(
        uid: ds['uid'],
        email: ds['email'],
        phone: ds['phone'],
        name: ds['name'],
        bank: ds['bank'],
        bankAddress: ds['bankAddress'],
        bankOwner: ds['bankOwner'],
    );
  }

  factory Login.fromSnapshot(DocumentSnapshot ss) {
    return Login(
        uid: ss.get('uid'),
        email: ss.get('email'),
        phone: ss.get('phone'),
        name: ss.get('name'),
        bank: ss.get('bank'),
        bankAddress: ss.get('bankAddress'),
        bankOwner: ss.get('bankOwner'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid.toString(),
      'email': email.toString(),
      'phone': phone.toString(),
      'name': name.toString(),
      'bank': bank.toString(),
      'bankAddress': bankAddress.toString(),
      'bankOwner': bankOwner.toString(),
    };
  }
}
