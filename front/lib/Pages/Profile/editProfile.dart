import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:test_url/Components/ProfileRoute/loginHeader.dart';
import 'package:test_url/Pages/Profile/showProfile.dart';

import '../../Components/HomeRoute/ProjectAndServiceSuggest.dart';
import '../../Components/HomeRoute/homeListHeader.dart';
import '../../Setting/numbers.dart';
import '../../Setting/platform.dart';
import '../../Setting/strings.dart';
import '../../Styles/animations.dart';

class EditProfile extends StatelessWidget {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    bool _mobileView = _width < mobileViewMaxWidth ? true : false;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: isOnIos
          ? CupertinoNavigationBar(
              middle: Text(
                profilePageTitle,
                style: theme.textTheme.headline5,
              ),
            )
          : AppBar(
              title: Text(profilePageTitle),
              centerTitle: true,
              textTheme: theme.textTheme,
            ),
      backgroundColor: theme.backgroundColor,
      body: Scrollbar(
        controller: _scrollController,
        isAlwaysShown: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              bottom: pagesBottomMargin,
              left: pagesRightAndLeftMargin(_width, _mobileView),
              right: pagesRightAndLeftMargin(_width, _mobileView),
            ),
            child: Column(
              children: [
                Text('Email@example.com'),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    initialValue: 'Sample Name',
                    // controller: signinEmailController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    initialValue: 'Sample Education',
                    // controller: signinEmailController,
                    decoration: InputDecoration(
                      labelText: 'Education',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    initialValue: 'Sample Description',
                    // controller: signinEmailController,
                    decoration: InputDecoration(
                      labelText: 'Discription',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text(
                    'change',
                    style: theme.textTheme.bodyText1,
                  ),
                  onPressed: () => {},
                ),
                RaisedButton(
                  child: Text(
                    'view profile',
                    style: theme.textTheme.bodyText1,
                  ),
                  onPressed: () => {
                    pushNewScreenWithRouteSettings(
                      context,
                      settings: null,
                      screen: ShowProfile(),
                      pageTransitionAnimation: changePageAnimation,
                    )
                  },
                ),
                HomeListHeader(
                  'Your Projects',
                  () => {
                    //TODO
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 175,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) =>
                        ProjectAndServiceSuggest(
                      'http://138.201.6.240:8001/media/blog_photos/increase-virgool.jpg',
                      30,
                      'sample project',
                    ),
                  ),
                ),
                HomeListHeader(
                  'Your Services',
                  () => {
                    //TODO
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 175,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) =>
                        ProjectAndServiceSuggest(
                      'http://138.201.6.240:8001/media/blog_photos/omid4.jpg',
                      100,
                      'sample service',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
