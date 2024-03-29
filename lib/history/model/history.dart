import 'dart:convert';
import 'package:itaxi/joiner/model/joiner.dart';
import 'package:itaxi/place/model/place.dart';
import 'package:itaxi/place/model/ktxPlace.dart';
import 'package:itaxi/post/model/post.dart';
import 'package:itaxi/post/model/ktxPost.dart';

class History {
  History({
    this.capacity,
    this.departure,
    this.deptTime,
    this.destination,
    this.id,
    this.ownerName,
    this.participantNum,
    this.postType,
    this.sale,
    this.status,
    this.joiners,
    this.stopovers,
  });

  int? capacity;
  HistoryPlace? departure;
  String? deptTime;
  HistoryPlace? destination;
  int? id;
  String? ownerName;
  int? participantNum;
  int? postType;
  int? sale;
  int? status;
  List<Joiner>? joiners;
  List<HistoryPlace?>? stopovers;

  History copyWith({
    int? capacity,
    HistoryPlace? departure,
    String? deptTime,
    HistoryPlace? destination,
    int? id,
    String? owner,
    int? participantNum,
    int? postType,
    int? sale,
    int? status,
    List<Joiner>? joiners,
    List<HistoryPlace?>? stopovers,
  }) =>
      History(
        capacity: capacity ?? this.capacity,
        departure: departure ?? this.departure,
        deptTime: deptTime ?? this.deptTime,
        destination: destination ?? this.destination,
        id: id ?? this.id,
        ownerName: owner ?? this.ownerName,
        participantNum: participantNum ?? this.participantNum,
        postType: postType ?? this.postType,
        sale: sale ?? this.sale,
        status: status ?? this.status,
        joiners: joiners ?? this.joiners,
        stopovers: stopovers ?? this.stopovers,
      );

  Post toPost() {
    Post result = Post(
      id: id,
      uid: '',
      postType: postType,
      departure: departure!.toPlace(),
      destination: destination!.toPlace(),
      deptTime: deptTime,
      capacity: capacity,
      participantNum: participantNum,
      status: status,
      joiners: joiners,
      stopovers: List<Place?>.from(stopovers!.map((x) => x!.toPlace())),
    );
    return result;
  }

  KtxPost toKtxPost() {
    KtxPost result = KtxPost(
      id: id,
      uid: '',
      departure: departure!.toKtxPlace(),
      destination: destination!.toKtxPlace(),
      deptTime: deptTime,
      capacity: capacity,
      participantNum: participantNum,
      status: status,
      joiners: joiners,
    );
    return result;
  }

  factory History.fromDocs(Map<String, dynamic> ds) => History(
        capacity: ds["capacity"],
        departure: HistoryPlace.fromDocs(ds["departure"]),
        deptTime: ds["deptTime"],
        destination: HistoryPlace.fromDocs(ds["destination"]),
        id: ds["id"],
        ownerName: ds["ownerName"],
        participantNum: ds["participantNum"],
        postType: ds["postType"],
        sale: ds["sale"],
        status: ds["status"],
        stopovers: ds["stopovers"] == null ? null : List<HistoryPlace>.from(ds["stopovers"].map((x) => HistoryPlace.fromDocs(x))),
      );

  factory History.fromDetailDocs(Map<String, dynamic> ds) => History(
        capacity: ds["capacity"],
        departure: HistoryPlace.fromDocs(ds["departure"]),
        deptTime: ds["deptTime"],
        destination: HistoryPlace.fromDocs(ds["destination"]),
        id: ds["id"],
        ownerName: ds["ownerName"],
        participantNum: ds["participantNum"],
        postType: ds["postType"],
        sale: ds["sale"],
        status: ds["status"],
        joiners: List<Joiner>.from(ds["joiners"].map((x) => Joiner.fromDocs(x))),
        stopovers: ds["stopovers"] == null ? null : List<HistoryPlace>.from(ds["stopovers"].map((x) => HistoryPlace.fromDocs(x))),
      );

  Map<String, dynamic> toMap() => {
        "capacity": capacity,
        "departure": departure,
        "deptTime": deptTime,
        "destination": destination,
        "id": id,
        "ownerName": ownerName,
        "participantNum": participantNum,
        "postType": postType,
        "sale": sale,
        "status": status,
        "joiners": joiners,
        "stopovers": stopovers,
      };
}

class HistoryPlace {
  HistoryPlace({
    this.cnt,
    this.id,
    this.name,
  });

  int? cnt;
  int? id;
  String? name;

  HistoryPlace copyWith({
    int? cnt,
    int? id,
    String? name,
  }) =>
      HistoryPlace(
        cnt: cnt ?? this.cnt,
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory HistoryPlace.fromDocs(Map<String, dynamic> ds) => HistoryPlace(
        cnt: ds["cnt"],
        id: ds["id"],
        name: ds["name"],
      );

  Map<String, dynamic> toMap() => {
        "cnt": cnt,
        "id": id,
        "name": name,
      };

  Place? toPlace() {
    Place? result = Place(
      id: id,
      name: name,
      cnt: cnt,
      placeType: 0,
    );

    return result;
  }

  KtxPlace? toKtxPlace() {
    KtxPlace? result = KtxPlace(
      id: id,
      name: name,
      cnt: cnt,
    );

    return result;
  }
}
