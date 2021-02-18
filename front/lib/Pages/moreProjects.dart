import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_url/Components/HomeRoute/ProjectAndServiceSuggest.dart';
import 'package:test_url/Setting/numbers.dart';
import 'package:test_url/Setting/platform.dart';

class MoreProjects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();

    double _width = MediaQuery.of(context).size.width;
    bool _mobileView = _width < mobileViewMaxWidth ? true : false;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: isOnIos
          ? CupertinoNavigationBar(
              middle: Text(
                'Project',
                style: theme.textTheme.headline5,
              ),
            )
          : AppBar(
              title: Text('Project'),
              centerTitle: true,
              textTheme: theme.textTheme,
            ),
      backgroundColor: theme.backgroundColor,
      body: Container(
        width: _width < 800
            ? 300
            : _width < 1200
                ? 600
                : 900,
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          bottom: pagesBottomMargin,
          left: pagesRightAndLeftMargin(_width, _mobileView),
          right: pagesRightAndLeftMargin(_width, _mobileView),
        ),
        child: Scrollbar(
          isAlwaysShown: true,
          controller: _scrollController,
          child: GridView.count(
            controller: _scrollController,
            // padding: EdgeInsets.only(
            //   left: _mobileView ? _width / 8 : _width / 6,
            //   top: pagesTopMargin,
            //   right: _mobileView ? _width / 8 : _width / 6,
            //   bottom: pagesBottomMargin,
            // ),
            crossAxisCount: _width < 800
                ? 1
                : _width < 1200
                    ? 3
                    : 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            children: [
              ProjectAndServiceSuggest('title', 'description', 52, '74'),
              ProjectAndServiceSuggest('title', 'description', 52, '74'),
              ProjectAndServiceSuggest('title', 'description', 52, '74'),
              ProjectAndServiceSuggest('title', 'description', 52, '74'),
              ProjectAndServiceSuggest('title', 'description', 52, '74'),
              ProjectAndServiceSuggest('title', 'description', 52, '74'),
            ],
          ),
        ),
      ),
    );
  }
}
