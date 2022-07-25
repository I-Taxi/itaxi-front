import 'package:flutter/material.dart';
import 'package:itaxi/model/post.dart';

Widget postListTile({
  required ColorScheme colorScheme,
  required TextTheme textTheme,
  required Post post,
}) {
  return Container(
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
  );
}
