import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_ver2/screens/camera_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'constant/screen_size.dart';
import 'file:///C:/flutterproject/instagram_clone_ver2/lib/screens/feed_screen.dart';
import 'package:instagram_clone_ver2/screens/profile_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.healing), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ''),
  ];

  List<Widget> _screens = [
    FeedScreen(),
    Container(color: Colors.pinkAccent),
    Container(color: Colors.cyanAccent),
    Container(color: Colors.deepOrangeAccent),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery.of(context).size;

    return Scaffold(
      key: _key,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: btmNavItems,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onTabItem,
      ),
    );
  }

  void _onTabItem(int index) {
    switch (index) {
      case 2:
        _openCamera();
        break;
      default:
        {
          setState(() {
            _selectedIndex = index;
          });
        }
    }
  }

  void _openCamera() async{
    if(await checkItfPermissionGranted(context))
      Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CameraScreen()));
    else{
      SnackBar snackBar = SnackBar(
          content: Text('접근 허용시 사용 가능함'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: (){
            _key.currentState.hideCurrentSnackBar();
            AppSettings.openAppSettings();
          },
        ),
      );
      _key.currentState.showSnackBar(snackBar);
    }
  }

  Future<bool> checkItfPermissionGranted(BuildContext context) async {
    Map<Permission, PermissionStatus> statuses = await [Permission.camera, Permission.microphone].request();
    bool permitted = true;

    statuses.forEach((permission, permissionStatus) {
      if(!permissionStatus.isGranted)
        permitted = false;
    });

    return permitted;
  }
}
