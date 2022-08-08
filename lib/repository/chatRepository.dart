import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itaxi/model/chat.dart';
import 'package:itaxi/model/post.dart';

class ChatRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> setPost({required Post post}) async {
    DocumentReference reference =
        _firestore.collection('Post').doc(post.id.toString());
    await reference.set(post.toFirestoreMap());
  }

  Future<void> setChat({required Post post, required Chat chat}) async {
    String cid = _firestore
        .collection('Post')
        .doc(post.id.toString())
        .collection('Chat')
        .doc(chat.chatTime.toString())
        .id;
    chat = chat.copyWith(id: cid);
    DocumentReference reference = _firestore
        .collection('Post')
        .doc(post.id.toString())
        .collection('Chat')
        .doc(cid);
    await reference.set(chat.toMap());
  }

  Stream<List<Chat>> getChats({required Post post}) {
    final snapshot = _firestore
        .collection('Post')
        .doc(post.id.toString())
        .collection('Chat')
        .snapshots();
    return snapshot.map((snapshot) {
      List<Chat> result = [];
      try {
        result = snapshot.docs.map((e) => Chat.fromDocs(e.data())).toList();
      } catch (e) {
        throw Exception(e);
      }
      return result;
    });
  }
}