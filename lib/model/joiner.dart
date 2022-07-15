import 'package:cloud_firestore/cloud_firestore.dart';

class Joiner {
  int? memberId;
  String? memberName;
  String? memberPhone;
  int? luggage;
  bool? owner;

  Joiner({
    this.memberId,
    this.memberName,
    this.memberPhone,
    this.luggage,
    this.owner,
  });

  Joiner copyWith({
    int? memberId,
    String? memberName,
    String? memberPhone,
    int? luggage,
    bool? owner,
  }) {
    return Joiner(
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

  factory Joiner.fromSnapshot(DocumentSnapshot ss) {
    return Joiner(
      memberId: ss.get('memberId'),
      memberName: ss.get('memberName'),
      memberPhone: ss.get('memberPhone'),
      luggage: ss.get('luggage'),
      owner: ss.get('owner'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'memberId': memberId,
      'memberName': memberName,
      'memberPhone': memberPhone,
      'luggage': luggage,
      'owner': owner,
    };
  }
}
