import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
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
  List<Place?>? stopovers;

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
    this.stopovers,
  });

  Post copyWith(
      {int? id,
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
      List<Place?>? stopovers}) {
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
      stopovers: stopovers ?? this.stopovers,
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
    List<dynamic> stopOversFromDs = ds['stopovers'];
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
      joiners: List<Joiner>.from(
          ds['joiners'].map((json) => Joiner.fromUidDocs(json))),
      stopovers: (stopOversFromDs.isEmpty)
          ? []
          : List<Place>.from(
              ds['stopovers'].map((json) => Place.fromDocs(json))),
    );
  }

  factory Post.fromStopoverDocs(Map<String, dynamic> ds) {
    List<dynamic>? stopOversFromDs = ds['stopovers'];
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
      stopovers: (stopOversFromDs == null)
          ? []
          : List<Place>.from(
              ds['stopovers'].map((json) => Place.fromStopoverDocs(json))),
    );
  }

  factory Post.fromJoinerAndStopoversDocs(Map<String, dynamic> ds) {
    List<dynamic> stopOversFromDs = ds['stopovers'];
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
      joiners:
          List<Joiner>.from(ds['joiners'].map((json) => Joiner.fromDocs(json))),
      stopovers: (stopOversFromDs.isEmpty)
          ? []
          : List<Place>.from(
              ds['stopovers'].map((json) => Place.fromStopoverDocs(json))),
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
      'stopovers': stopovers,
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
      "stopoverIds": (stopovers == null || stopovers!.isEmpty)
          ? []
          : List<int>.from(stopovers!.map((stopover) => stopover!.id!)),
    };
  }

  Map<String, dynamic> toFirestoreMap() {
    List<int?> membersId = [];
    String postName = "";
    print(joiners);
    for (Joiner? joiner in joiners!) {
      membersId.add(joiner!.memberId);
    }

    postName =
        "(${departure!.name!}) -> (${destination!.name!}) #${DateFormat('MMd').format(DateTime.parse(deptTime!))}";

    return {
      'id': id,
      'postType': postType,
      'membersId': membersId,
      'postName': postName,
    };
  }

  Map<String, dynamic> toFirestoreOutChatMap() {
    List<int?> membersId = [];
    String postName = "";
    print(joiners);
    for (Joiner? joiner in joiners!) {
      membersId.add(joiner!.memberId);
    }

    postName =
        "(${departure!.name!}) -> (${destination!.name!}) #${DateFormat('MMd').format(DateTime.parse(deptTime!))}";

    return {
      'id': id,
      'postType': postType,
      'membersId': membersId,
      'postName': postName,
    };
  }
}
