import 'package:flutter/material.dart';

class VersionScreen extends StatefulWidget {
  const VersionScreen({Key? key}) : super(key: key);

  @override
  _VersionScreenState createState() => _VersionScreenState();
}

class _VersionScreenState extends State<VersionScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
      .of(context)
      .colorScheme;
  final textTheme = Theme
      .of(context)
      .textTheme;
  return SafeArea(
    child: Scaffold(
      appBar: AppBar(
          leading: BackButton(
            color: colorScheme.shadow,
          ),
          shadowColor: colorScheme.shadow,
          elevation: 1.0,
          centerTitle: true,
          title: Text(
            '버전정보/개발자',
            style: textTheme.subtitle1?.copyWith(
                color: colorScheme.onPrimary
            ),
          )
      ),
    ),
  );
  }
}
