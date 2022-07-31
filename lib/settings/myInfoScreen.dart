import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/settings/userInfoRefactorScreen.dart';

import '../model/userInfoList.dart';

class MyInfoScreen extends StatefulWidget {
  const MyInfoScreen({Key? key}) : super(key: key);

  @override
  _MyInfoScreenState createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  UserController _userController = Get.put(UserController());
  // Future<List<Login>> users = _userController.users;
  UserInfoList _userInfoList = UserInfoList();

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
    double constraint = MediaQuery.of(context).size.height;
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
          // child: Text(_userInfoList.bank as String),
          child: GetBuilder<UserController>(
            init: UserController(),
            builder: (_) {
              return FutureBuilder<UserInfoList>(
                future: _userController.users,
                builder: (BuildContext context, snapshot) {
                  if(snapshot.hasData) {
                    if(snapshot.data != null) {
                      return ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: constraint),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 20, left: 40),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 136,
                                    height: 128,
                                    child: Container(
                                      color: colorScheme.secondary,
                                    ),
                                  ),
                                  SizedBox(width: 24),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data!.name.toString(), style: textTheme.headline1!.copyWith(color: colorScheme.onPrimary)),
                                      Text(snapshot.data!.phone.toString(), style: textTheme.headline1!.copyWith(color: colorScheme.onPrimary)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15.0, left: 40.0, right: 40.0, bottom: 15.0),
                              child: Divider(
                                height: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 136,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Email", style: textTheme.headline1!.copyWith(color: colorScheme.onPrimary),),
                                        SizedBox(height: 10.0,),
                                        Text("계좌 은행", style: textTheme.headline1!.copyWith(color: colorScheme.onPrimary),),
                                        SizedBox(height: 10.0,),
                                        Text("계좌 번호", style: textTheme.headline1!.copyWith(color: colorScheme.onPrimary),)
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 24),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(snapshot.data!.email.toString(),
                                        style: textTheme.headline1!.copyWith(color: colorScheme.onPrimary, fontSize: 12.0),),
                                      SizedBox(height: 10.0,),
                                      Text(snapshot.data!.bank.toString(),
                                        style: textTheme.headline1!.copyWith(color: colorScheme.onPrimary),),
                                      SizedBox(height: 10.0,),
                                      Text(snapshot.data!.bankAddress.toString(),
                                        style: textTheme.headline1!.copyWith(color: colorScheme.onPrimary),)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 104,
                              height: 40,
                              child: TextButton(
                                child: Text("수정", style: textTheme.headline2!.copyWith(color: colorScheme.secondary),),
                                onPressed: () {
                                  Get.to(UserInfoRefactorScreen());
                                },
                              ),
                            )

                          ],
                        ),
                      );
                    } else {
                      return Text('오류입니다 :>');
                    }
                  }
                  else if (snapshot.hasError) {
                    print("확인2");
                    print(snapshot.error);
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
              );
            },
          ),
        )
      ),
    );
  }
}
