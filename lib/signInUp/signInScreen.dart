import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/signInController.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  SignInController _signInController = Get.put(SignInController());

  Pattern pattern = r'^(?=.*[a-zA-Z]{3,})(?=.*\d{3,})';
  late RegExp regExp;
  final _formKey = GlobalKey<FormState>();

  checkFields() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
        child: Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        children: [
          Text(
            'Logo',
            style: textTheme.headline1,
          ),
          TextFormField(
              autocorrect: false,
              decoration: InputDecoration(
                  filled: true,
                  labelText: 'Custom ID',
                  labelStyle: textTheme.bodyText1
                      ?.copyWith(color: colorScheme.tertiary)),
              validator: (value) {
                if (value!.isEmpty) return 'Please enter Custom ID';
                // pattern 변경하면 됨.
                // regExp = RegExp(pattern.toString());
                // if (!regExp.hasMatch(value)) return 'Username is invalid'
                return null;
              }),
          const SizedBox(height: 12.0),
          TextFormField(
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Custom PW',
              ),
              validator: (value) {
                if (value!.isEmpty) return 'Please enter Custom PW';
                return null;
              }),
        ],
      ),
    ));
  }
}
