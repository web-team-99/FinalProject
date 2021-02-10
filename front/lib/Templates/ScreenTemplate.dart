import 'package:flutter/material.dart';

import 'package:test_url/Setting/numbers.dart';

//....!!!!....!!!!....!!!!....!!!!....!!!!....!!!!....!!!!....!!!!....!!!!....!!!!....!!!!....!!!!
//this is just a template for creating new pages
//we never use this class in our code
//....!!!!....!!!!....!!!!....!!!!....!!!!....!!!!....!!!!....!!!!....!!!!....!!!!....!!!!....!!!!

class ScreenTemplate extends StatelessWidget {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    bool _mobileView = _width < mobileViewMaxWidth ? true : false;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Scrollbar(
        controller: _scrollController,
        isAlwaysShown: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            margin: EdgeInsets.only(
              top: pagesTopMargin,
              bottom: pagesBottomMargin,
              left: pagesRightAndLeftMargin(_width, _mobileView),
              right: pagesRightAndLeftMargin(_width, _mobileView),
            ),
            child: Text('template'),
          ),
        ),
      ),
    );
  }
}
