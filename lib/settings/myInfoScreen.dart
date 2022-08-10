import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/settings/userInfoRefactorScreen.dart';

import '../model/userInfoList.dart';

class MyInfoScreen extends StatelessWidget {
  MyInfoScreen({Key? key}) : super(key: key);

  UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shadowColor: colorScheme.shadow,
          elevation: 1.0,
          centerTitle: true,
          title: Text(
            '내정보',
            style: textTheme.subtitle1?.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: colorScheme.tertiary,
            ),
          ),
        ),
        backgroundColor: colorScheme.background,
        body: SingleChildScrollView(
          child: GetBuilder<UserController>(
            builder: (_) {
              return FutureBuilder<UserInfoList>(
                future: _userController.users,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.w,
                          vertical: 24.h,
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 136.w,
                                  height: 128.h,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 44.h,
                                    horizontal: 38.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colorScheme.secondary,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(4),
                                    ),
                                  ),
                                  child: Image.asset(
                                    width: 58.0.w,
                                    height: 40.h,
                                    'assets/logo_2.png',
                                  ),
                                ),
                                SizedBox(width: 24.w),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.name.toString(),
                                      style: textTheme.headline1!.copyWith(
                                        color: colorScheme.onPrimary,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4.0.h,
                                    ),
                                    Text(
                                      snapshot.data!.phone.toString(),
                                      style: textTheme.headline1!.copyWith(
                                        color: colorScheme.onPrimary,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Divider(
                              height: 0.3,
                              color: colorScheme.tertiary,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Email",
                                      style: textTheme.headline1!.copyWith(
                                          color: colorScheme.onPrimary),
                                    ),
                                    SizedBox(
                                      width: 32.w,
                                    ),
                                    Text(
                                      snapshot.data!.email.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.headline1!.copyWith(
                                        color: colorScheme.onPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "계좌 은행",
                                      style: textTheme.headline1!.copyWith(
                                          color: colorScheme.onPrimary),
                                    ),
                                    SizedBox(
                                      width: 32.w,
                                    ),
                                    Text(
                                      snapshot.data!.bank.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.headline1!.copyWith(
                                        color: colorScheme.onPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "계좌 번호",
                                      style: textTheme.headline1!.copyWith(
                                          color: colorScheme.onPrimary),
                                    ),
                                    SizedBox(
                                      width: 32.w,
                                    ),
                                    Text(
                                      snapshot.data!.bankAddress.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.headline1!.copyWith(
                                        color: colorScheme.onPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 280.h,
                            ),
                            TextButton(
                              onPressed: () async {
                                Get.to(UserInfoRefactorScreen());
                              },
                              // textTheme 적용 해야함
                              child: Text(
                                '정보 수정',
                                style: textTheme.subtitle1!.copyWith(
                                  color: colorScheme.tertiary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          '로딩 중 오류가 발생하였습니다 :<',
                          style: textTheme.headline2?.copyWith(
                            color: colorScheme.tertiary,
                            fontFamily: 'NotoSans',
                          ),
                        ),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error}',
                        style: textTheme.headline2?.copyWith(
                          color: colorScheme.tertiary,
                          fontFamily: 'NotoSans',
                        ),
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
        ),
      ),
    );
  }
}
