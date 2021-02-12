import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_url/Components/ProfileRoute/loginHeader.dart';

import '../../Setting/numbers.dart';
import '../../Setting/platform.dart';
import '../../Setting/strings.dart';

class ShowProfile extends StatelessWidget {
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
                LoginHeader('Name'),
                Text('Sample name'),
                LoginHeader('Education'),
                Text('Sample education'),
                LoginHeader('Description'),
                Text('Sample description'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
