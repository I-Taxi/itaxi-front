import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? id;
  String? uid;
  String? departure;
  String? destination;
  String? deptTime;
  String? capacity;
  String? participantNum;
  String? status;

  Post({
    this.id,
    this.uid,
    this.departure,
    this.destination,
    this.deptTime,
    this.capacity,
    this.participantNum,
    this.status,
  });

  Post copyWith({
    String? id,
    String? uid,
    String? departure,
    String? destination,
    String? deptTime,
    String? capacity,
    String? participantNum,
    String? status,
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
    };
  }
}
