import 'package:cloud_firestore/cloud_firestore.dart';

class Notice {
  int? id;
  String? title;
  String? content;
  int? viewCnt;
  String? createdAt;

  Notice({
    this.id,
    this.title,
    this.content,
    this.viewCnt,
    this.createdAt,
});

  Notice copyWith({
    int? id,
    String? title,
    String? content,
    int? viewCnt,
    String? createdAt,
}) {
    return Notice(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      viewCnt: viewCnt ?? this.viewCnt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Notice.fromDocs(Map<String, dynamic> ds) {
    return Notice(
      id: ds['id'],
      title: ds['title'],
      content: ds['content'],
      viewCnt: ds['viewCnt'],
      createdAt: ds['createdAt'],
    );
  }

  factory Notice.fromSnapshot(DocumentSnapshot ss){
    return Notice(
      id: ss.get('id'),
      title: ss.get('title'),
      content: ss.get('content'),
      viewCnt: ss.get('viewCnt'),
      createdAt: ss.get('createdAt'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title' : title,
      'content' : content,
      'viewCnt' : viewCnt,
      'createdAt' : createdAt,
    };
  }
}