import 'package:flutter/material.dart';
import 'package:test_url/Setting/numbers.dart';
import 'package:test_url/Setting/strings.dart';
import 'package:test_url/Styles/icons.dart';

class CustomErrorWidget extends StatelessWidget {
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
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  networkErrorIcon,
                  size: _width / 7,
                ),
                Text(networkErrorTitle, style: theme.textTheme.headline2),
                Text(
                  networkErrorDetails,
                  style: theme.textTheme.headline5,
                ),
                Divider(
                  height: 10,
                  thickness: 3,
                ),
                RaisedButton(
                  child: Text(
                    networkErrorButtonString,
                    style: theme.textTheme.bodyText1,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
