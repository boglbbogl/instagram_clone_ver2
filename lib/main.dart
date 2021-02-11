import 'package:flutter/material.dart';
import 'package:instagram_clone_ver2/models/firebase_auth_state.dart';
import 'package:instagram_clone_ver2/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'constant/meterial_white.dart';
import 'home_page.dart';
import 'screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();
  Widget _currentWidget;

  @override
  Widget build(BuildContext context) {
    _firebaseAuthState.watchAuthChange();
    return ChangeNotifierProvider<FirebaseAuthState>.value(
      value: _firebaseAuthState,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: white,
        ),
        home: Consumer<FirebaseAuthState>(
            builder: (BuildContext context, FirebaseAuthState firebaseAuthState, Widget child) {

              switch(firebaseAuthState.firebaseAuthStatus){

                case FirebaseAuthStatus.signout:
                  _currentWidget = AuthScreen();
                  break;
                case FirebaseAuthStatus.signin:
                  _currentWidget = HomePage();
                  break;
                default:
                  _currentWidget = MyProgressIndicator();
              }
              return AnimatedSwitcher(
                  duration: Duration(milliseconds: 2000),
                      child: _currentWidget,
              );
            },
        ),
        // home: AuthScreen(),
      ),
    );
  }
}
