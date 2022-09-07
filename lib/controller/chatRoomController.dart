import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/model/chat.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/repository/chatRepository.dart';

class ChatRoomController extends GetxController {
  late Post post;
  late Stream<List<Chat>> chats;
  late UserController _userController = Get.find();
  TextEditingController chatTextController = TextEditingController();
  bool texting = false;

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
    update();
  }

  void getChats({required Post post}) {
    chats = ChatRepository().getChats(post: post);
    update();
  }

  Future<void> submitChat() async {
    Chat chat = Chat(
      memberId: _userController.uid,
      memberName: _userController.name!,
      chatData: chatTextController.text.trim(),
      chatTime: Timestamp.fromDate(DateTime.now()),
    );
    await ChatRepository().setChat(post: post, chat: chat);
  }

  Future<void> joinChat() async {
    Chat chat = Chat(
      chatData: '${_userController.name!}님이 들어왔습니다.',
      chatTime: Timestamp.fromDate(DateTime.now()),
    );
    await ChatRepository().setChatLog(post: post, chat: chat);
  }

  Future<void> outChat() async {
    Chat chat = Chat(
      chatData: '${_userController.name!}님이 나갔습니다.',
      chatTime: Timestamp.fromDate(DateTime.now()),
    );
    await ChatRepository().setChatLog(post: post, chat: chat);
  }
}
