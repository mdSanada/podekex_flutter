import 'package:flutter/material.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          labelStyle: TextStyle( //up to your taste
              fontWeight: FontWeight.w700
          ),
          indicatorSize: TabBarIndicatorSize.label, //makes it better
          labelColor: Color(0xff1a73e8), //Google's sweet blue
          unselectedLabelColor: Color(0xff5f6368), //niceish grey
          isScrollable: true, //up to your taste
          indicator: MD2Indicator( //it begins here
              indicatorHeight: 3,
              indicatorColor: Color(0xff1a73e8),
              indicatorSize: MD2IndicatorSize.normal //3 different modes tiny-normal-full
          ),
          tabs: <Widget>[
            Tab(
              text: "Home",
            ),
            Tab(
              text: "Personal info",
            ),
            Tab(
              text: "Data & personalization",
            ),
          ],
        ),
      ),
    );
  }
}
