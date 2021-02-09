import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:test_url/Components/CustomRaisedButton.dart';
import 'package:test_url/Components/asyncImageLoader.dart';
import 'package:test_url/Pages/More/blogPost.dart';
import 'package:test_url/Setting/numbers.dart';
import 'package:test_url/Setting/strings.dart';
import 'package:test_url/Styles/animations.dart';
import 'package:test_url/Styles/icons.dart';

class BlogPostElement extends StatelessWidget {
  final int _postId;
  final String _imageUrl;
  final String _title;
  final String _date;
  final String _time;

  BlogPostElement(
      this._postId, this._title, this._imageUrl, this._date, this._time);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    bool _mobileView = _width < mobileViewMaxWidth ? true : false;
    ThemeData theme = Theme.of(context);

    return Card(
      elevation: 3,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.5,
            child: Container(
              // height: _width / 4,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: AsyncImageLoader(_imageUrl),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(
                            blogDateIcon,
                          ),
                        ),
                        Text(
                          _date,
                          style: theme.textTheme.subtitle1,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(
                            blogTimeIcon,
                          ),
                        ),
                        Text(
                          _time,
                          style: theme.textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: SelectableText(
                    _title,
                    style: theme.textTheme.headline5,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomRaisedButton(
                      title: blogReadMore,
                      onPressed: () => {
                        pushNewScreenWithRouteSettings(
                          context,
                          settings: null,
                          screen: BlogPost(_postId),
                          pageTransitionAnimation: changePageAnimation,
                        )
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
