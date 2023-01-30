import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itaxi/model/place.dart';

class FavoritePlace {
  int? id;
  Place? place;

  FavoritePlace({
    this.id,
    this.place,
  });

  FavoritePlace copyWith({
    int? id,
    Place? place,
  }) {
    return FavoritePlace(
      id: id ?? this.id,
      place: place ?? this.place,
    );
  }

  factory FavoritePlace.fromDocs(Map<String, dynamic> ds) {
    return FavoritePlace(
      id: ds['id'],
      place: Place.fromDocs(ds['place']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'place': place?.toMap(),
    };
  }
}
