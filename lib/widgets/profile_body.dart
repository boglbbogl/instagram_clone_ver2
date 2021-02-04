import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_ver2/constant/common_size.dart';
import 'package:instagram_clone_ver2/constant/screen_size.dart';

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  SelectTab _selectTab = SelectTab.left;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              _userName(),
              _userBio(),
              _editProfileBtn(),
              _tabButton(),
              _selectedIndicator(),
            ]),
          ),
          _imagesPager(),
        ],
      ),
    );
  }

  SliverToBoxAdapter _imagesPager() {
    return SliverToBoxAdapter(
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: 1,
            children: List.generate(
                30,
                (index) => CachedNetworkImage(
                  fit: BoxFit.cover,
                    imageUrl: 'https://picsum.photos/id/$index/100/100')),
          ),
        );
  }

  Widget _selectedIndicator() {
    return AnimatedContainer(
      alignment: _selectTab == SelectTab.left
          ? Alignment.centerLeft
          : Alignment.centerRight,
      duration: Duration(milliseconds: 1000),
      child: Container(
        height: 3,
        width: size.width / 2,
        color: Colors.black87,
      ),
      curve: Curves.fastOutSlowIn,
    );
  }

  Row _tabButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: IconButton(
            icon: ImageIcon(
              AssetImage('assets/images/grid.png'),
              color:
                  _selectTab == SelectTab.left ? Colors.black : Colors.black26,
            ),
            onPressed: () {
              setState(() {
                _selectTab = SelectTab.left;
              });
            },
          ),
        ),
        Expanded(
          child: IconButton(
            icon: ImageIcon(
              AssetImage('assets/images/saved.png'),
              color:
                  _selectTab == SelectTab.left ? Colors.black26 : Colors.black,
            ),
            onPressed: () {
              setState(() {
                _selectTab = SelectTab.right;
              });
            },
          ),
        ),
      ],
    );
  }

  Padding _editProfileBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: SizedBox(
        height: 24,
        child: OutlineButton(
          onPressed: () {},
          borderSide: BorderSide(color: Colors.black45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Edit profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _userName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
        'username',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _userBio() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
        'I do not know',
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }
}

enum SelectTab { left, right }
