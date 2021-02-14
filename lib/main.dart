import 'package:flutter/material.dart';
import 'package:instagram_clone_ver2/models/firebase_auth_state.dart';
import 'package:instagram_clone_ver2/models/firestore/user_model.dart';
import 'package:instagram_clone_ver2/models/user_model_state.dart';
import 'package:instagram_clone_ver2/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'constant/meterial_white.dart';
import 'home_page.dart';
import 'repo/user_network_repository.dart';
import 'screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();
  Widget _currentWidget;

  @override
  Widget build(BuildContext context) {
    _firebaseAuthState.watchAuthChange();
    return MultiProvider(
      providers: [
    ChangeNotifierProvider<FirebaseAuthState>.value(
    value: _firebaseAuthState),
      ChangeNotifierProvider<UserModelState>(create: (_)=>UserModelState(),),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: white,
        ),
        home: Consumer<FirebaseAuthState>(
            builder: (BuildContext context, FirebaseAuthState firebaseAuthState, Widget child) {
              switch(firebaseAuthState.firebaseAuthStatus){
                case FirebaseAuthStatus.signout:
                  _clearUserModel(context);
                  _currentWidget = AuthScreen();
                  break;
                case FirebaseAuthStatus.signin:
                  _initUserModel(firebaseAuthState, context);
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

  void _initUserModel(FirebaseAuthState firebaseAuthState, BuildContext context) {

    UserModelState userModelState = Provider.of<UserModelState>(context, listen: false);

    userModelState.currentStreamSub = userNetworkRepository
        .getUserModelStream(firebaseAuthState.firebaseUser.uid)
        .listen((userModel) {
          userModelState.userModel = userModel;
    });
  }

  void _clearUserModel(BuildContext context) {
    UserModelState userModelState = Provider.of<UserModelState>(context, listen: false);
    userModelState.clear();
  }
}
