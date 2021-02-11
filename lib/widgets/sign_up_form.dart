import 'package:flutter/material.dart';
import 'package:instagram_clone_ver2/constant/auth_input_decor.dart';
import 'package:instagram_clone_ver2/constant/common_size.dart';
import 'package:instagram_clone_ver2/models/firebase_auth_state.dart';
import 'package:provider/provider.dart';

import 'or_divider.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _cpwController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _cpwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(common_gap),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: common_l_gap,
              ),
              Image.asset('assets/images/insta_text_logo.png'),
              TextFormField(
                cursorColor: Colors.black54,
                controller: _emailController,
                decoration: textInputDecor('Email'),
                validator: (text) {
                  if (text.isNotEmpty && text.contains('@')) {
                    return null;
                  } else {
                    return 'Not Email form';
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              TextFormField(
                obscureText: true,
                cursorColor: Colors.black54,
                controller: _pwController,
                decoration: textInputDecor('Password'),
                validator: (text) {
                  if (text.isNotEmpty && text.length > 3) {
                    return null;
                  } else {
                    return 'Not Password form';
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              TextFormField(
                obscureText: true,
                cursorColor: Colors.black54,
                controller: _cpwController,
                decoration: textInputDecor('Confirm password'),
                validator: (text) {
                  if (text.isNotEmpty && _pwController.text == text) {
                    return null;
                  } else {
                    return 'Not Confirm';
                  }
                },
              ),
              SizedBox(
                height: common_s_gap,
              ),
              _submitButton(context),
              SizedBox(
                height: common_s_gap,
              ),
              OrDivider(),
              FlatButton.icon(
                  textColor: Colors.blue,
                  onPressed: () {
                    Provider.of<FirebaseAuthState>(context, listen: false).changeFirebaseAuthStatus(FirebaseAuthStatus.signin);
                  },
                  icon: ImageIcon(AssetImage('assets/images/facebook.png')),
                  label: Text('Login with facebook'))
            ],
          ),
        ),
      ),
    );
  }

  FlatButton _submitButton(BuildContext context) {
    return FlatButton(
      color: Colors.blue,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          print('sucess');
          Provider.of<FirebaseAuthState>(context, listen: false).registerUser(context, email: _emailController.text, password: _pwController.text);
        }
      },
      child: Text(
        'Join',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(common_s_gap),
      ),
    );
  }
}

