import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itaxi/model/joiner.dart';

class Post {
  String? id;
  String? uid;
  String? depId;
  String? dstId;
  String? deptTime;
  int? capacity;
  int? participantNum;
  int? status;
  int? luggage;
  Joiner? joiners;

  Post({
    this.id,
    this.uid,
    this.depId,
    this.dstId,
    this.deptTime,
    this.capacity,
    this.participantNum,
    this.status,
    this.luggage,
    this.joiners,
  });

  Post copyWith({
    String? id,
    String? uid,
    String? depId,
    String? dstId,
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
      depId: depId ?? this.depId,
      dstId: dstId ?? this.dstId,
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
      depId: ds['depId'],
      dstId: ds['dstId'],
      deptTime: ds['deptTime'],
      capacity: ds['capacity'],
      participantNum: ds['participantNum'],
      status: ds['status'],
      luggage: ds['luggage'],
      joiners: ds['joiners'],
    );
  }

  factory Post.fromSnapshot(DocumentSnapshot ss) {
    return Post(
      id: ss.get('id'),
      uid: ss.get('uid'),
      depId: ss.get('depId'),
      dstId: ss.get('dstId'),
      deptTime: ss.get('deptTime'),
      capacity: ss.get('capacity'),
      participantNum: ss.get('partifipanNum'),
      status: ss.get('status'),
      luggage: ss.get('luggage'),
      joiners: ss.get('joiners'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'depId': depId,
      'dstId': dstId,
      'deptTime': deptTime,
      'capacity': capacity,
      'participantNum': participantNum,
      'status': status,
      'luggage': luggage,
      'joiners': joiners,
    };
  }
}
