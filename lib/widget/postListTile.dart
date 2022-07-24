import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/addPostController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/model/post.dart';
import 'package:numberpicker/numberpicker.dart';

Widget postListTile({
  required BuildContext context,
  required Post post,
}) {
  AddPostController _addPostController = Get.put(AddPostController());
  PostController _postsController = Get.put(PostController());
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
              child: Column(
                children: [
                  Text(
                    '입장하시겠습니까?',
                    style: textTheme.subtitle1
                        ?.copyWith(color: colorScheme.tertiary),
                  ),
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
      width: 352.0,
      height: 80.0,
      padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [
          BoxShadow(
            color: colorScheme.tertiary,
            offset: Offset(1.0, 1.0),
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
                '${post.deptTime}',
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
                    '${post.depId}',
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
                    '${post.dstId}',
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
