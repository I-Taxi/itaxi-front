import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/chatRoomController.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/model/chat.dart';
import 'package:itaxi/model/joiner.dart';

Widget ChatDetailListTile(
    {required BuildContext context,
    required Chat chat,
    required List<Joiner>? joiners}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  late UserController _userController = Get.find();
  late ChatRoomController _chatRoomController = Get.find();

  Joiner? owner;

  joiners?.forEach((joiner) {
    if (joiner.owner!) {
      owner = joiner;
    }
  });

  var isFirst = true;
  return (_userController.uid == chat.uid)
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            isFirst
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat('jm').format(chat.chatTime!.toDate()),
                        style: textTheme.bodyText2?.copyWith(
                          color: colorScheme.tertiaryContainer,
                          fontSize: Platform.isIOS ? 11 : 10,
                        ),
                      ),
                      SizedBox(width: 7.w),
                      Text(
                        chat.memberName!,
                        style: textTheme.bodyText2?.copyWith(
                          color: colorScheme.onTertiary,
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
                  constraints: BoxConstraints(minWidth: 36.w, maxWidth: 342.w),
                  decoration: BoxDecoration(
                    color: colorScheme.secondary,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12)),
                  ),
                  child: SelectableText(
                    chat.chatData!,
                    style: textTheme.bodyText1
                        ?.copyWith(color: colorScheme.primary),
                  ),
                ),
              ],
            ),
          ],
        )
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isFirst
                ? Row(
                    children: [
                      Text(
                        chat.memberName!,
                        style: textTheme.bodyText2
                            ?.copyWith(color: colorScheme.onTertiary),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        DateFormat('jm').format(chat.chatTime!.toDate()),
                        style: textTheme.bodyText2?.copyWith(
                          color: colorScheme.tertiaryContainer,
                          fontSize: Platform.isIOS ? 11 : 10,
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
                  constraints: BoxConstraints(minWidth: 36.w, maxWidth: 342.w),
                  decoration: BoxDecoration(
                    color: colorScheme.onBackground,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12)),
                  ),
                  child: SelectableText(
                    chat.chatData!,
                    style: textTheme.bodyText1?.copyWith(
                      color: colorScheme.onTertiary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
}

// Widget meChatListTile(BuildContext context, String content, bool isFirst) {
//   final colorScheme = Theme.of(context).colorScheme;
//   final textTheme = Theme.of(context).textTheme;

//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.end,
//     children: [
//       isFirst
//           ? Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   "00:00 AM",
//                   style: textTheme.bodyText2?.copyWith(
//                     color: colorScheme.tertiaryContainer,
//                     fontSize: Platform.isIOS ? 11 : 10,
//                   ),
//                 ),
//                 SizedBox(width: 7.w),
//                 Text(
//                   "You",
//                   style: textTheme.bodyText2?.copyWith(
//                     color: colorScheme.onTertiary,
//                   ),
//                 ),
//               ],
//             )
//           : SizedBox(
//               height: 4.h,
//             ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Container(
//             padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
//             constraints: BoxConstraints(minWidth: 36.w),
//             decoration: BoxDecoration(
//               color: colorScheme.secondary,
//               borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(12),
//                   bottomLeft: Radius.circular(12),
//                   bottomRight: Radius.circular(12)),
//             ),
//             child: SelectableText(
//               content,
//               style: textTheme.bodyText1?.copyWith(color: colorScheme.primary),
//             ),
//           ),
//         ],
//       ),
//     ],
//   );
// }

// Widget youChatListTile(BuildContext context, String content, bool isFirst) {
//   final colorScheme = Theme.of(context).colorScheme;
//   final textTheme = Theme.of(context).textTheme;

//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       isFirst
//           ? Row(
//               children: [
//                 Text(
//                   "OOO학부생",
//                   style: textTheme.bodyText2
//                       ?.copyWith(color: colorScheme.onTertiary),
//                 ),
//                 SizedBox(width: 5.w),
//                 Text(
//                   "00:00 AM",
//                   style: textTheme.bodyText2?.copyWith(
//                     color: colorScheme.tertiaryContainer,
//                     fontSize: Platform.isIOS ? 11 : 10,
//                   ),
//                 ),
//               ],
//             )
//           : SizedBox(
//               height: 4.h,
//             ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Container(
//             padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
//             constraints: BoxConstraints(minWidth: 36.w),
//             decoration: BoxDecoration(
//               color: colorScheme.onBackground,
//               borderRadius: const BorderRadius.only(
//                   topRight: Radius.circular(12),
//                   bottomLeft: Radius.circular(12),
//                   bottomRight: Radius.circular(12)),
//             ),
//             child: SelectableText(
//               content,
//               style: textTheme.bodyText1?.copyWith(
//                 color: colorScheme.onTertiary,
//               ),
//             ),
//           ),
//         ],
//       ),
//     ],
//   );
// }
