import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String? id;
  String? uid;
  String? memberName;
  int? memberId;
  String? chatData;
  Timestamp? chatTime;

  Chat({
    this.id,
    this.uid,
    this.memberName,
    this.memberId,
    this.chatData,
    this.chatTime,
  });

  Chat copyWith({
    String? id,
    String? uid,
    String? memberName,
    int? memberId,
    String? chatData,
    Timestamp? chatTime,
  }) {
    return Chat(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      memberName: memberName ?? this.memberName,
      memberId: memberId ?? this.memberId,
      chatData: chatData ?? this.chatData,
      chatTime: chatTime ?? this.chatTime,
    );
  }

  factory Chat.fromDocs(Map<String, dynamic> ds) {
    return Chat(
      id: ds['id'],
      uid: ds['uid'],
      memberName: ds['memberName'],
      memberId: ds['memberId'],
      chatData: ds['chatData'],
      chatTime: ds['chatTime'],
    );
  }

  factory Chat.fromSnapShot(DocumentSnapshot ss) {
    return Chat(
      id: ss.get('id'),
      uid: ss.get('uid'),
      memberName: ss.get('memberName'),
      memberId: ss.get('memberId'),
      chatData: ss.get('chatData'),
      chatTime: ss.get('chatTime'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'memberName': memberName,
      'memberId': memberId,
      'chatData': chatData,
      'chatTime': chatTime,
    };
  }
}
