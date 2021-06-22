import 'package:flutter/material.dart';

import 'inputPage.dart';
import 'creadPage.dart';
import 'homePage.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> with SingleTickerProviderStateMixin {
  String title = 'BottomNavigationBar';

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TabBarView(
          children: <Widget>[
            HomePage(),
            SearchPage(),
            InputPage(),
          ],
          controller: _tabController,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.greenAccent.withOpacity(0.50),
              spreadRadius: 4,
              blurRadius: 11,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.white,
          child: TabBar(
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            indicator: UnderlineTabIndicator(borderSide: BorderSide.none),
            indicatorColor: Colors.green,
            tabs: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 50),
                child: Tab(
                  icon: Icon(
                    Icons.home,
                    size: 24.0,
                  ),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.search,
                  size: 24.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 50),
                child: Tab(
                  icon: Icon(
                    Icons.person_add_alt_1,
                    size: 24.0,
                  ),
                ),
              ),
            ],
            controller: _tabController,
          ),
        ),
      ),
    );
  }
}
