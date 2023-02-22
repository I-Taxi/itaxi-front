import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itaxi/joiner/model/joiner.dart';
import 'package:url_launcher/url_launcher.dart';

Widget passengerListTile({required BuildContext context, required Joiner joiner}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Container(
    padding: EdgeInsets.fromLTRB(0.w, 0.h, 0.w, 19.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        joiner.owner == true
            ? Image.asset(
                width: 39,
                'assets/icon/owner.png',
              )
            : Image.asset(
                width: 39,
                'assets/icon/not_owner.png',
              ),
        SizedBox(
          width: 15.w,
        ),
        Text(
          '${joiner.memberName}',
          style: textTheme.bodyText1?.copyWith(
            color: colorScheme.onTertiary,
          ),
        ),
        const Spacer(),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            final Uri launchUri = Uri.parse('tel:${joiner.memberPhone}');
            if (await canLaunchUrl(launchUri)) {
              await launchUrl(launchUri);
            } else {
              throw Exception('Failed call');
            }
          },
          child: Image.asset(
            width: 24,
            'assets/icon/phone.png',
          ),
        ),
        SizedBox(
          width: 15.w,
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            final Uri launchUri = Uri.parse('sms:${joiner.memberPhone}');
            if (await canLaunchUrl(launchUri)) {
              await launchUrl(launchUri);
            } else {
              throw Exception('Failed sms');
            }
          },
          child: Image.asset(
            width: 24,
            'assets/icon/message.png',
          ),
        ),
      ],
    ),
  );
}
