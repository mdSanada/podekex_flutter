import 'package:flutter/material.dart';
import 'package:podekex_flutter/consts/consts_app.dart';
import 'package:podekex_flutter/pages/home_page/widgets/app_bar_home.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            top: -(240 / 4.7),
            left: screenWidth - (240 / 1.6),
            child: Opacity(
                child: Image.asset(
                  ConstsApp.blackPokeball,
                  height: 240,
                  width: 240,
                ),
                opacity: 0.1),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: statusBarHeight,
                ),
                AppBarHome(),
                Expanded(
                  child: Container(
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                          title: Text('Pokemon2'),
                        ),
                        ListTile(
                          title: Text('Pokemon3'),
                        ),
                        ListTile(
                          title: Text('Pokemon4'),
                        ),
                        ListTile(
                          title: Text('Pokemon5'),
                        ),
                        ListTile(
                          title: Text('Pokemon6'),
                        ),
                        ListTile(
                          title: Text('Pokemon7'),
                        ),
                        ListTile(
                          title: Text('Pokemon7'),
                        ),
                        ListTile(
                          title: Text('Pokemon7'),
                        ),
                        ListTile(
                          title: Text('Pokemon7'),
                        ),
                        ListTile(
                          title: Text('Pokemon7'),
                        ),
                        ListTile(
                          title: Text('Pokemon7'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
