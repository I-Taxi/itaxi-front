import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/userController.dart';

import '../model/userInfoList.dart';

class MyInfoScreen extends StatefulWidget {
  const MyInfoScreen({Key? key}) : super(key: key);

  @override
  _MyInfoScreenState createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  UserController _userController = Get.put(UserController());
  // Future<List<Login>> users = _userController.users;

  @override
  void initState() {
    _userController.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: colorScheme.shadow,
          ),
          shadowColor: colorScheme.shadow,
          elevation: 1.0,
          centerTitle: true,
          title: Text(
            '내정보',
            style: textTheme.subtitle1?.copyWith(
                color: colorScheme.onPrimary
            ),
          )
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<List<UserInfoList>>(
            future: _userController.users,
            builder: (BuildContext context, snapshot) {
              print("확인1");
              if(snapshot.hasData) {
                if(snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Text(snapshot.data![index].name as String),
                      );
                    },
                  );
                } else {
                  return Text('dafsd');
                }
              }
              else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error}',
                  ),
                );
              }
              return LinearProgressIndicator(
                color: colorScheme.secondary,
              );
            },
          ),
        )
      ),
    );
  }
}
