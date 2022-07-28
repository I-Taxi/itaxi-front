import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/model/post.dart';

Widget afterTimelineListTile(
    {required BuildContext context, required Post post}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog();
          });
    },
    child: Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      height: 80.0,
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
                '13:00',
                // DateFormat('HH:mm').format(DateTime.parse(post.deptTime!)),
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
                    '한동대',
                    // '${post.departure?.name}',
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
                    '영일대',
                    // '${post.destination?.name}',
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
