import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itaxi/model/joiner.dart';
import 'package:itaxi/model/place.dart';

class Post {
  int? id;
  String? uid;
  int? postType;
  Place? departure;
  Place? destination;
  String? deptTime;
  int? capacity;
  int? participantNum;
  int? status;
  List<Joiner>? joiners;

  Post({
    this.id,
    this.uid,
    this.postType,
    this.departure,
    this.destination,
    this.deptTime,
    this.capacity,
    this.participantNum,
    this.status,
    this.joiners,
  });

  Post copyWith({
    int? id,
    String? uid,
    int? postType,
    Place? departure,
    Place? destination,
    String? deptTime,
    int? capacity,
    int? participantNum,
    int? largeLuggageNum,
    int? smallLuggageNum,
    int? status,
    int? luggage,
    List<Joiner>? joiners,
  }) {
    return Post(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      postType: postType ?? this.postType,
      departure: departure ?? this.departure,
      destination: destination ?? this.destination,
      deptTime: deptTime ?? this.deptTime,
      capacity: capacity ?? this.capacity,
      participantNum: participantNum ?? this.participantNum,
      status: status ?? this.status,
      joiners: joiners ?? this.joiners,
    );
  }

  factory Post.fromDocs(Map<String, dynamic> ds) {
    return Post(
      id: ds['id'],
      uid: ds['uid'],
      postType: ds['postType'],
      departure: Place.fromDocs(ds['departure']),
      destination: Place.fromDocs(ds['destination']),
      deptTime: ds['deptTime'],
      capacity: ds['capacity'],
      participantNum: ds['participantNum'],
      status: ds['status'],
    );
  }

  factory Post.fromPostAllDocs(Map<String, dynamic> ds) {
    return Post(
      id: ds['id'],
      uid: ds['uid'],
      postType: ds['postType'],
      departure: Place.fromDocs(ds['departure']),
      destination: Place.fromDocs(ds['destination']),
      deptTime: ds['deptTime'],
      capacity: ds['capacity'],
      participantNum: ds['participantNum'],
      status: ds['status'],
      joiners: List<Joiner>.from(ds['joiners'].map((json) => Joiner.fromUidDocs(json))),
    );
  }

  factory Post.fromJoinerDocs(Map<String, dynamic> ds) {
    return Post(
      id: ds['id'],
      uid: ds['uid'],
      postType: ds['postType'],
      departure: Place.fromDocs(ds['departure']),
      destination: Place.fromDocs(ds['destination']),
      deptTime: ds['deptTime'],
      capacity: ds['capacity'],
      participantNum: ds['participantNum'],
      status: ds['status'],
      joiners: List<Joiner>.from(ds['joiners'].map((json) => Joiner.fromDocs(json))),
    );
  }

  factory Post.fromSnapshot(DocumentSnapshot ss) {
    return Post(
      id: ss.get('id'),
      uid: ss.get('uid'),
      postType: ss.get('postType'),
      departure: Place.fromSnapshot(ss.get('departure')),
      destination: Place.fromSnapshot(ss.get('destination')),
      deptTime: ss.get('deptTime'),
      capacity: ss.get('capacity'),
      participantNum: ss.get('partifipanNum'),
      status: ss.get('status'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'postType': postType,
      'departure': departure,
      'destination': destination,
      'deptTime': deptTime,
      'capacity': capacity,
      'participantNum': participantNum,
      'status': status,
      'joiners': joiners,
    };
  }

  Map<String, dynamic> toAddPostMap() {
    return {
      "uid": uid,
      "postType": postType,
      "depId": departure!.id,
      "dstId": destination!.id,
      "deptTime": deptTime,
      "capacity": capacity,
      "stopoverIds": <int>[1, 2, 3],
    };
  }

  Map<String, dynamic> toFirestoreMap() {
    return {
      'id': id,
      'postType': postType,
    };
  }
}
