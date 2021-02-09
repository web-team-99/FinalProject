import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:test_url/Setting/numbers.dart';
import 'package:test_url/Setting/platform.dart';
import 'package:test_url/Setting/strings.dart';

class MessagesRoute extends StatefulWidget {
  @override
  _MessagesRouteState createState() => _MessagesRouteState();
}

class _MessagesRouteState extends State<MessagesRoute> {
  final _scrollController = ScrollController();
  int _state = 0;

  changeState() {
    setState(() {
      if (_state == 0) {
        _state = 1;
      } else {
        _state = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    bool _mobileView = _width < mobileViewMaxWidth ? true : false;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: isOnIos
          ? CupertinoNavigationBar(
              middle: Text(
                messagesPageTitle,
                style: theme.textTheme.headline5,
              ),
            )
          : AppBar(
              title: Text(messagesPageTitle),
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
                Text(
                  'messages state: ' + _state.toString(),
                  style: theme.textTheme.bodyText2,
                ),
                RaisedButton(
                  child: Text(
                    'change state',
                    style: theme.textTheme.bodyText1,
                  ),
                  onPressed: () => changeState(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
