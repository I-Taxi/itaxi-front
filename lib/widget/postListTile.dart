import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/addPostController.dart';
import 'package:itaxi/controller/navigationController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/model/post.dart';
import 'package:numberpicker/numberpicker.dart';

Widget postListTile({
  required BuildContext context,
  required Post post,
}) {
  AddPostController _addPostController = Get.put(AddPostController());
  PostController _postController = Get.put(PostController());
  NavigationController _navigationController = Get.put(NavigationController());
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 150,
              padding: EdgeInsets.fromLTRB(40.0, 32.0, 40.0, 12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '나의 짐',
                        style: textTheme.headline2
                            ?.copyWith(color: colorScheme.tertiary),
                      ),
                      StatefulBuilder(
                        builder: (_, setState) {
                          return NumberPicker(
                            value: _addPostController.luggage,
                            minValue: 0,
                            maxValue: 6,
                            step: 1,
                            itemHeight: 20,
                            itemWidth: 50,
                            itemCount: 2,
                            axis: Axis.horizontal,
                            haptics: true,
                            onChanged: (value) {
                              setState(() {
                                _addPostController.luggage = value;
                              });
                            },
                            textStyle: textTheme.headline2
                                ?.copyWith(color: colorScheme.tertiary),
                            selectedTextStyle: textTheme.headline2
                                ?.copyWith(color: colorScheme.secondary),
                          );
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          '취소',
                          style: textTheme.headline1
                              ?.copyWith(color: colorScheme.tertiary),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _postController.fetchJoin(
                              postId: post.id!,
                              luggage: _addPostController.luggage);
                          _navigationController.changeIndex(0);
                          Get.back();
                        },
                        child: Text(
                          '입장',
                          style: textTheme.headline1
                              ?.copyWith(color: colorScheme.secondary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
    child: Container(
      height: 80.0,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow,
            offset: const Offset(1.0, 1.0),
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('HH:mm').format(DateTime.parse(post.deptTime!)),
                style:
                    textTheme.headline2?.copyWith(color: colorScheme.onPrimary),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Icon(
                Icons.crop_square,
                color: colorScheme.secondary,
                size: 28.0,
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.circle_outlined,
                    color: colorScheme.tertiary,
                    size: 12.0,
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    '${post.departure?.name}',
                    style: textTheme.bodyText1
                        ?.copyWith(color: colorScheme.onPrimary),
                  ),
                ],
              ),
              SizedBox(
                height: 12.0,
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: colorScheme.tertiary,
                    size: 12.0,
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    '${post.destination?.name}',
                    style: textTheme.bodyText1
                        ?.copyWith(color: colorScheme.onPrimary),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          if (post.luggage != null)
            for (int i = 0; i < post.luggage!; i++)
              Icon(
                Icons.shopping_bag,
                color: colorScheme.tertiary,
                size: 24,
              ),
        ],
      ),
    ),
  );
}
