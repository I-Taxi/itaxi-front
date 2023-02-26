import 'package:cloud_firestore/cloud_firestore.dart';

class KtxPlace {
  int? id;
  String? name;
  int? cnt;

  KtxPlace({
    this.id,
    this.name,
    this.cnt,
  });

  KtxPlace copyWith({
    int? id,
    String? name,
    int? cnt,
  }) {
    return KtxPlace(
      id: id ?? this.id,
      name: name ?? this.name,
      cnt: cnt ?? this.cnt,
    );
  }

  factory KtxPlace.fromDocs(Map<String, dynamic> ds) {
    return KtxPlace(
      id: ds['id'],
      name: ds['name'],
      cnt: ds['cnt'],
    );
  }

  factory KtxPlace.fromSnapshot(DocumentSnapshot ss) {
    return KtxPlace(
      id: ss.get('id'),
      name: ss.get('name'),
      cnt: ss.get('cnt'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cnt': cnt,
    };
  }
}
