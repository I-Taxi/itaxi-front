import 'package:cloud_firestore/cloud_firestore.dart';

class Login {
  int? id;
  String? uid;
  String? name;
  String? email;
  String? phone;

  Login({
    this.id,
    this.uid,
    this.name,
    this.email,
    this.phone
  });

  Login copyWith({
    int? id,
    String? uid,
    String? name,
    String? email,
    String? phone,
  }) {
    return Login(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  factory Login.fromDocs(Map<String, dynamic> ds) {
    return Login(
      id: ds['id'],
      uid: ds['uid'],
      name: ds['name'],
      email: ds['email'],
      phone: ds['phone'],
    );
  }

  factory Login.fromSnapshot(DocumentSnapshot ss) {
    return Login(
      id: ss.get('id'),
      uid: ss.get('uid'),
      name: ss.get('name'),
      email: ss.get('email'),
      phone: ss.get('phone'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}