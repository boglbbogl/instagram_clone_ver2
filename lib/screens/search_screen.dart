import 'package:flutter/material.dart';
import 'package:instagram_clone_ver2/widgets/rounded_avatar.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<bool> followings = List.generate(30, (index) => false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView.separated(
          itemCount: followings.length,
          separatorBuilder: (context, index) {
            return Divider(color: Colors.grey,);
          },
          itemBuilder: (context, index) {
            return ListTile(
              onTap: (){
                setState(() {
                  followings[index] = !followings[index];
                });
              },
              leading: RoundedAvatar(),
              title: Text('username $index'),
              subtitle: Text('user bio number $index'),
              trailing: Container(
                height: 30,
                width: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: followings[index] ? Colors.red[50]: Colors.blue[50],
                  border: Border.all(color: followings[index] ? Colors.red : Colors.blue, width: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  followings[index] ? 'following' : 'follower',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold),),
              ),
            );
          },
        ));
  }
}
