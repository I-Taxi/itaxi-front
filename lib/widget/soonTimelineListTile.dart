import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/model/post.dart';

Widget soonTimelineListTile(
    {required BuildContext context, required Post post}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  PostController _postController = Get.put(PostController());
  HistoryController _historyController = Get.find();

  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 320,
              padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.postType == 1 ? '택시' : '카풀',
                    style: textTheme.headline1
                        ?.copyWith(color: colorScheme.tertiary),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    DateFormat('yyyy년 MM월 dd일 E')
                        .format(DateTime.parse(post.deptTime!)),
                    style: textTheme.subtitle1
                        ?.copyWith(color: colorScheme.tertiary),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat('HH:mm')
                                .format(DateTime.parse(post.deptTime!)),
                            style: textTheme.headline2
                                ?.copyWith(color: colorScheme.onPrimary),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Icon(
                            Icons.crop_square,
                            color: colorScheme.tertiary,
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
                          const SizedBox(
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
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        '연락처',
                        style: textTheme.subtitle1
                            ?.copyWith(color: colorScheme.tertiary),
                      ),
                      Expanded(
                        child: Divider(
                          color: colorScheme.shadow,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          _postController.fetchOutJoin(postId: post.id!);
                          _historyController.getHistorys();
                          Get.back();
                        },
                        child: Text(
                          '방 나가기',
                          style: textTheme.headline1
                              ?.copyWith(color: colorScheme.tertiary),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          '확인',
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
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        // borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          width: 2,
          color: colorScheme.secondary,
        ),
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
              const SizedBox(
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
