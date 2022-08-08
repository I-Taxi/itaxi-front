import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String? id;
  String? memberId;
  String? memberName;
  String? chatData;
  Timestamp? chatTime;

  Chat({
    this.id,
    this.memberId,
    this.memberName,
    this.chatData,
    this.chatTime,
  });

  Chat copyWith({
    String? id,
    String? memberId,
    String? memberName,
    String? chatData,
    Timestamp? chatTime,
  }) {
    return Chat(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      memberName: memberName ?? this.memberName,
      chatData: chatData ?? this.chatData,
      chatTime: chatTime ?? this.chatTime,
    );
  }

  factory Chat.fromDocs(Map<String, dynamic> ds) {
    return Chat(
      id: ds['id'],
      memberId: ds['memberId'],
      memberName: ds['memberName'],
      chatData: ds['chatData'],
      chatTime: ds['chatTime'],
    );
  }

  factory Chat.fromSnapShot(DocumentSnapshot ss) {
    return Chat(
      id: ss.get('id'),
      memberId: ss.get('memberId'),
      memberName: ss.get('memberName'),
      chatData: ss.get('chatData'),
      chatTime: ss.get('chatTime'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'memberId': memberId,
      'memberName': memberName,
      'chatData': chatData,
      'chatTime': chatTime,
    };
  }
}
