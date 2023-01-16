import 'package:cloud_firestore/cloud_firestore.dart';

class Place {
  int? id;
  String? name;
  int? placeType;
  int? cnt;

  Place({
    this.id,
    this.name,
    this.placeType,
    this.cnt,
  });

  Place copyWith({
    int? id,
    String? name,
    int? placeType,
    int? cnt,
  }) {
    return Place(
      id: id ?? this.id,
      name: name ?? this.name,
      placeType: placeType ?? this.placeType,
      cnt: cnt ?? this.cnt,
    );
  }

  factory Place.fromDocs(Map<String, dynamic> ds) {
    return Place(
      id: ds['id'],
      name: ds['name'],
      placeType: 0,
      cnt: ds['cnt'],
    );
  }

  factory Place.fromSnapshot(DocumentSnapshot ss) {
    return Place(
      id: ss.get('id'),
      name: ss.get('name'),
      placeType: ss.get('placeType'),
      cnt: ss.get('cnt'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'placeType': placeType,
      'cnt': cnt,
    };
  }
}
