import 'package:cloud_firestore/cloud_firestore.dart';

class Joiner {
  String? uid;
  int? memberId;
  String? memberName;
  String? memberPhone;
  int? luggage;
  bool? owner;

  Joiner({
    this.uid,
    this.memberId,
    this.memberName,
    this.memberPhone,
    this.luggage,
    this.owner,
  });

  Joiner copyWith({
    String? uid,
    int? memberId,
    String? memberName,
    String? memberPhone,
    int? luggage,
    bool? owner,
  }) {
    return Joiner(
      uid: uid ?? this.uid,
      memberId: memberId ?? this.memberId,
      memberName: memberName ?? this.memberName,
      memberPhone: memberPhone ?? this.memberPhone,
      luggage: luggage ?? this.luggage,
      owner: owner ?? this.owner,
    );
  }

  factory Joiner.fromDocs(Map<String, dynamic> ds) {
    return Joiner(
      memberId: ds['memberId'],
      memberName: ds['memberName'],
      memberPhone: ds['memberPhone'],
      luggage: ds['luggage'],
      owner: ds['owner'],
    );
  }

  factory Joiner.fromUidDocs(Map<String, dynamic> ds) {
    return Joiner(
      uid: ds['uid'],
      memberId: ds['memberId'],
      memberName: ds['memberName'],
      memberPhone: ds['memberPhone'],
      luggage: ds['luggage'],
      owner: ds['owner'],
    );
  }

  factory Joiner.fromSnapshot(DocumentSnapshot ss) {
    return Joiner(
      uid: ss.get('uid'),
      memberId: ss.get('memberId'),
      memberName: ss.get('memberName'),
      memberPhone: ss.get('memberPhone'),
      luggage: ss.get('luggage'),
      owner: ss.get('owner'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'memberId': memberId,
      'memberName': memberName,
      'memberPhone': memberPhone,
      'luggage': luggage,
      'owner': owner,
    };
  }
}
