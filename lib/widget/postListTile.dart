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
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          // color: colorScheme.tertiary,
          offset: Offset(1.0, 1.0),
          blurRadius: 2.0,
        ),
      ],
    ),
    child: Row(
      children: [
        Column(
          children: [
            Text(
              '${post.deptTime}',
              style: textTheme.headline2,
            ),
            Icon(Icons.abc),
          ],
        ),
      ],
    ),
  );
}
