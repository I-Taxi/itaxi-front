import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoList {
  String? phone;
  String? email;
  String? uid;
  String? name;
  int? id;

  UserInfoList({
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
      phone: phone ?? this.phone,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      id: id ?? this.id

    );
  }

  factory UserInfoList.fromDocs(Map<String, dynamic> ds) {
    return UserInfoList(
      phone: ds['phone'],
      email: ds['email'],
      uid: ds['uid'],
      name: ds['name'],
      id: ds['id'],
    );
  }

  factory UserInfoList.fromSnapshot(DocumentSnapshot ss) {
    return UserInfoList(
      phone: ss.get('phone'),
      email: ss.get('email'),
      uid: ss.get('uid'),
      name: ss.get('name'),
      id: ss.get('id'),

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'email': email,
      'uid': uid,
      'name': name,
      'id': id,
    };
  }
}