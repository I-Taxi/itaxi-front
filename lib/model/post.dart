import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itaxi/model/joiner.dart';
import 'package:itaxi/model/place.dart';

class Post {
  int? id;
  String? uid;
  Place? departure;
  Place? destination;
  String? deptTime;
  int? capacity;
  int? participantNum;
  int? status;
  int? luggage;
  Joiner? joiners;

  Post({
    this.id,
    this.uid,
    this.departure,
    this.destination,
    this.deptTime,
    this.capacity,
    this.participantNum,
    this.status,
    this.luggage,
    this.joiners,
  });

  Post copyWith({
    int? id,
    String? uid,
    Place? departure,
    Place? destination,
    String? deptTime,
    int? capacity,
    int? participantNum,
    int? status,
    int? luggage,
    Joiner? joiners,
  }) {
    return Post(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      departure: departure ?? this.departure,
      destination: destination ?? this.destination,
      deptTime: deptTime ?? this.deptTime,
      capacity: capacity ?? this.capacity,
      participantNum: participantNum ?? this.participantNum,
      status: status ?? this.status,
      luggage: luggage ?? this.luggage,
      joiners: joiners ?? this.joiners,
    );
  }

  factory Post.fromDocs(Map<String, dynamic> ds) {
    return Post(
      id: ds['id'],
      uid: ds['uid'],
      departure: Place.fromDocs(ds['departure']),
      destination: Place.fromDocs(ds['destination']),
      deptTime: ds['deptTime'],
      capacity: ds['capacity'],
      participantNum: ds['participantNum'],
      status: ds['status'],
      luggage: ds['luggage'],
      // joiners: Joiner.fromDocs(ds['joiners']),
    );
  }

  factory Post.fromSnapshot(DocumentSnapshot ss) {
    return Post(
      id: ss.get('id'),
      uid: ss.get('uid'),
      departure: Place.fromSnapshot(ss.get('departure')),
      destination: Place.fromSnapshot(ss.get('destination')),
      deptTime: ss.get('deptTime'),
      capacity: ss.get('capacity'),
      participantNum: ss.get('partifipanNum'),
      status: ss.get('status'),
      luggage: ss.get('luggage'),
      joiners: Joiner.fromSnapshot(ss.get('joiners')),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'departure': departure,
      'destination': destination,
      'deptTime': deptTime,
      'capacity': capacity,
      'participantNum': participantNum,
      'status': status,
      'luggage': luggage,
      'joiners': joiners,
    };
  }

  Map<String, dynamic> toAddPostMap() {
    return {
      "uid": uid,
      "depId": departure?.id,
      "dstId": destination?.id,
      "deptTime": deptTime,
      "capacity": capacity,
      "luggage": luggage,
      "postType": 0,
    };
  }
}
