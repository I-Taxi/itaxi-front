import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? id;
  String? uid;
  String? departure;
  String? destination;
  String? deptTime;
  int? capacity;
  int? participantNum;
  int? status;
  int? luggage;

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
  });

  Post copyWith({
    String? id,
    String? uid,
    String? departure,
    String? destination,
    String? deptTime,
    int? capacity,
    int? participantNum,
    int? status,
    int? luggage,
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
    );
  }

  factory Post.fromDocs(Map<String, dynamic> ds) {
    return Post(
      id: ds['id'],
      uid: ds['uid'],
      departure: ds['departure'],
      destination: ds['destination'],
      deptTime: ds['deptTime'],
      capacity: ds['capacity'],
      participantNum: ds['participantNum'],
      status: ds['status'],
      luggage: ds['luggage'],
    );
  }

  factory Post.fromSnapshot(DocumentSnapshot ss) {
    return Post(
      id: ss.get('id'),
      uid: ss.get('uid'),
      departure: ss.get('departure'),
      destination: ss.get('destination'),
      deptTime: ss.get('deptTime'),
      capacity: ss.get('capacity'),
      participantNum: ss.get('partifipanNum'),
      status: ss.get('status'),
      luggage: ss.get('luggage'),
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
    };
  }
}
