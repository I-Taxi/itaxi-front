import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget meChatListTile(BuildContext context, String content, bool isFirst) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      isFirst
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "00:00 AM",
                  style: textTheme.bodyText1?.copyWith(
                    color: colorScheme.shadow,
                    fontSize: 10,
                  ),
                ),
                SizedBox(width: 7.w),
                Text(
                  "You",
                  style: textTheme.bodyText1?.copyWith(
                    color: colorScheme.onPrimary,
                    fontSize: 13,
                  ),
                ),
              ],
            )
          : SizedBox(
              height: 4.h,
            ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
            constraints: BoxConstraints(minWidth: 36.w),
            decoration: BoxDecoration(
              color: colorScheme.secondary,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
            ),
            child: SelectableText(
              content,
              style: textTheme.subtitle1?.copyWith(
                color: colorScheme.primary,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget youChatListTile(BuildContext context, String content, bool isFirst) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      isFirst
          ? Row(
              children: [
                Text(
                  "OOO학부생",
                  style: textTheme.subtitle1
                      ?.copyWith(color: colorScheme.onPrimary, fontSize: 13),
                ),
                SizedBox(width: 5.w),
                Text(
                  "00:00 AM",
                  style: textTheme.bodyText1?.copyWith(
                    color: colorScheme.shadow,
                    fontSize: 10,
                  ),
                ),
              ],
            )
          : SizedBox(
              height: 4.h,
            ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
            constraints: BoxConstraints(minWidth: 36.w),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
            ),
            child: SelectableText(
              content,
              style: textTheme.subtitle1?.copyWith(
                color: colorScheme.onPrimary,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
