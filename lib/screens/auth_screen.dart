import 'package:flutter/material.dart';
import 'package:instagram_clone_ver2/widgets/sign_in_form.dart';
import 'package:instagram_clone_ver2/widgets/sign_up_form.dart';

import 'profile_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Widget signUpForm = SignUpForm();
  Widget signInForm = SignInForm();

  Widget currentWidget;

  @override
  void initState() {
    if (currentWidget == null) currentWidget = signUpForm;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            AnimatedSwitcher(child: currentWidget, duration: duration),
            Container(
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    if (currentWidget is SignUpForm) {
                      currentWidget = signInForm;
                    } else {
                      currentWidget = signUpForm;
                    }
                  });
                },
                child: Text('go to sign up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
