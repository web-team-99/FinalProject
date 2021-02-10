import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:test_url/Enums/moreOptionsEnum.dart';
import 'package:test_url/Functions/moreFunctions.dart';
import 'package:test_url/Setting/numbers.dart';
import 'package:test_url/Styles/animations.dart';

class GridElement extends StatelessWidget {
  final MoreOption _moreOption;
  final int blogPostId;

  GridElement(this._moreOption, {this.blogPostId});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    bool _mobileView = _width < mobileViewMaxWidth ? true : false;
    ThemeData theme = Theme.of(context);

    return InkWell(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                getIcon(_moreOption),
                size: _mobileView ? _width / 10 : _width / 25,
                color: Colors.white,
              ),
              Text(
                getText(_moreOption),
                textAlign: TextAlign.center,
                style: _mobileView
                    ? theme.textTheme.bodyText1
                    : _width < 800
                        ? theme.textTheme.caption
                        : theme.textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        pushNewScreenWithRouteSettings(
          context,
          settings: null,
          screen: blogPostId == null
              ? getScreen(
                  _moreOption,
                )
              : getScreen(
                  _moreOption,
                  blogPostId: blogPostId,
                ),
          pageTransitionAnimation: changePageAnimation,
        );
      },
    );
  }
}
