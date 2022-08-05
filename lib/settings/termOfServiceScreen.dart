import 'package:flutter/material.dart';

class TermOfServiceScreen extends StatefulWidget {
  const TermOfServiceScreen({Key? key}) : super(key: key);

  @override
  _TermOfServiceScreenState createState() => _TermOfServiceScreenState();
}

class _TermOfServiceScreenState extends State<TermOfServiceScreen> {
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
              '이용약관',
              style: textTheme.subtitle1?.copyWith(
                  color: colorScheme.onPrimary
              ),
            )
        ),
      ),
    );
  }
}
