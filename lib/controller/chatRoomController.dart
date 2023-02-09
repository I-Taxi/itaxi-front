import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:itaxi/fcm/fcmController.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/model/chat.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/model/ktxPost.dart';
import 'package:itaxi/model/history.dart';
import 'package:itaxi/repository/chatRepository.dart';
import 'package:itaxi/repository/ktxChatRepository.dart';

class ChatRoomController extends GetxController {
  late Post post;
  late KtxPost ktxPost;
  late Stream<List<Chat>> chats;
  late UserController _userController = Get.find();
  int postType = -1;

  TextEditingController chatTextController = TextEditingController();
  bool texting = false;

  String? token;

  @override
  void onInit() {
    fetchFcmToken().then((_) {
      super.onInit();
    });
  }

  Future<void> fetchFcmToken() async {
    token = await FirebaseMessaging.instance.getToken();
  }

  void changeTexting(bool texting) {
    this.texting = texting;
    update();
  }

  void clearTexting() {
    chatTextController.clear();
    texting = false;
    update();
  }

  void getPost({required Post post}) {
    this.post = post;
    postType = post.postType!;
    update();
  }

  void getKtxPost({required KtxPost ktxPost}) {
    this.ktxPost = ktxPost;
    postType = 3;
    update();
  }

  void getChats({required Post post}) {
    chats = ChatRepository().getChats(post: post);

    update();
  }

  void getKtxChats({required KtxPost ktxPost}) {
    chats = KtxChatRepository().getChats(post: ktxPost);

    update();
  }

  Future<void> submitChat() async {
    Chat chat = Chat(
      uid: _userController.uid,
      memberName: _userController.name!,
      memberId: _userController.memberId,
      chatData: chatTextController.text.trim(),
      chatTime: Timestamp.fromDate(DateTime.now()),
    );
    if (postType != 3) {
      await ChatRepository().setChat(post: post, chat: chat);
    } else {
      await KtxChatRepository().setChat(post: ktxPost, chat: chat);
    }
  }

  Future<void> joinChat({required Post post}) async {
    Chat chat = Chat(
      chatData: '${_userController.name!}님이 들어왔습니다.',
      chatTime: Timestamp.fromDate(DateTime.now()),
    );
    await ChatRepository().setChatLog(post: post, chat: chat);
  }

  Future<void> ktxJoinChat({required KtxPost post}) async {
    Chat chat = Chat(
      chatData: '${_userController.name!}님이 들어왔습니다.',
      chatTime: Timestamp.fromDate(DateTime.now()),
    );
    await KtxChatRepository().setChatLog(post: post, chat: chat);
  }

  Future<void> outChat({required Post post}) async {
    Chat chat = Chat(
      chatData: '${_userController.name!}님이 나갔습니다.',
      chatTime: Timestamp.fromDate(DateTime.now()),
    );
    await ChatRepository().setChatLog(post: post, chat: chat);
  }

  Future<void> ktxOutChat({required KtxPost post}) async {
    Chat chat = Chat(
      chatData: '${_userController.name!}님이 나갔습니다.',
      chatTime: Timestamp.fromDate(DateTime.now()),
    );
    await KtxChatRepository().setChatLog(post: post, chat: chat);
  }

  Future<void> changeOwnerChat({required String ownerName}) async {
    Chat chat = Chat(
      chatData: '이제 $ownerName님이 방장입니다.',
      chatTime: Timestamp.fromDate(DateTime.now()),
    );
    if (postType != 3) {
      await ChatRepository().setChatLog(post: post, chat: chat);
    } else {
      await KtxChatRepository().setChatLog(post: ktxPost, chat: chat);
    }
  }
}
