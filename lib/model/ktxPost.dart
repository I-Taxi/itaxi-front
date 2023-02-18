import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/model/joiner.dart';
import 'package:itaxi/model/ktxPlace.dart';

class KtxPost {
  int? id;
  String? uid;
  KtxPlace? departure;
  KtxPlace? destination;
  String? deptTime;
  int? capacity;
  int? participantNum;
  int? sale;
  int? status;
  List<Joiner>? joiners;

  KtxPost({
    this.id,
    this.uid,
    this.departure,
    this.destination,
    this.deptTime,
    this.capacity,
    this.participantNum,
    this.status,
    this.sale,
    this.joiners,
  });

  KtxPost copyWith({
    int? id,
    String? uid,
    int? postType,
    KtxPlace? departure,
    KtxPlace? destination,
    String? deptTime,
    int? capacity,
    int? participantNum,
    int? largeLuggageNum,
    int? smallLuggageNum,
    int? status,
    int? sale,
    List<Joiner>? joiners,
  }) {
    return KtxPost(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      departure: departure ?? this.departure,
      destination: destination ?? this.destination,
      deptTime: deptTime ?? this.deptTime,
      capacity: capacity ?? this.capacity,
      participantNum: participantNum ?? this.participantNum,
      status: status ?? this.status,
      sale: sale ?? this.sale,
      joiners: joiners ?? this.joiners,
    );
  }

  factory KtxPost.fromDocs(Map<String, dynamic> ds) {
    return KtxPost(
      id: ds['id'],
      departure: KtxPlace.fromDocs(ds['departure']),
      destination: KtxPlace.fromDocs(ds['destination']),
      deptTime: ds['deptTime'],
      capacity: ds['capacity'],
      participantNum: ds['participantNum'],
      sale: ds['sale'],
      status: ds['status'],
    );
  }

  factory KtxPost.fromPostAllDocs(Map<String, dynamic> ds) {
    return KtxPost(
      id: ds['id'],
      departure: KtxPlace.fromDocs(ds['departure']),
      destination: KtxPlace.fromDocs(ds['destination']),
      deptTime: ds['deptTime'],
      capacity: ds['capacity'],
      participantNum: ds['participantNum'],
      status: ds['status'],
      sale: ds['sale'],
      joiners: List<Joiner>.from(
          ds['joiners'].map((json) => Joiner.fromUidDocs(json))),
    );
  }

  factory KtxPost.fromJoinerDocs(Map<String, dynamic> ds) {
    return KtxPost(
      id: ds['id'],
      departure: KtxPlace.fromDocs(ds['departure']),
      destination: KtxPlace.fromDocs(ds['destination']),
      deptTime: ds['deptTime'],
      capacity: ds['capacity'],
      participantNum: ds['participantNum'],
      status: ds['status'],
      sale: ds['sale'],
      joiners:
          List<Joiner>.from(ds['joiners'].map((json) => Joiner.fromDocs(json))),
    );
  }

  factory KtxPost.fromSnapshot(DocumentSnapshot ss) {
    return KtxPost(
      id: ss.get('id'),
      departure: KtxPlace.fromSnapshot(ss.get('departure')),
      destination: KtxPlace.fromSnapshot(ss.get('destination')),
      deptTime: ss.get('deptTime'),
      capacity: ss.get('capacity'),
      participantNum: ss.get('partifipanNum'),
      status: ss.get('status'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'departure': departure,
      'destination': destination,
      'deptTime': deptTime,
      'capacity': capacity,
      'participantNum': participantNum,
      'status': status,
      'sale': sale,
      'joiners': joiners,
    };
  }

  Map<String, dynamic> toAddPostMap() {
    return {
      "depId": departure!.id,
      "dstId": destination!.id,
      "deptTime": deptTime,
      "capacity": capacity,
      'sale': sale,
      "uid": uid,
    };
  }

  Map<String, dynamic> toFirestoreMap() {
    List<int?> membersId = [];
    String postName = "";

    for (Joiner? joiner in joiners!) {
      membersId.add(joiner!.memberId);
    }

    postName =
        "(${departure!.name!}) -> (${destination!.name!}) #${DateFormat('MMd').format(DateTime.parse(deptTime!))}";

    return {
      'id': id,
      'membersId': membersId,
      'postName': postName,
    };
  }
}
