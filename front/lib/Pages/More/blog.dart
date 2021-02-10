import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:test_url/Components/CustomRaisedButton.dart';
import 'package:test_url/Components/MoreRoute/blogPostElement.dart';
import 'package:test_url/Pages/customErrorWidget.dart';
import 'package:test_url/Components/customIndicator.dart';
import 'package:test_url/Functions/moreFunctions.dart';
import 'package:test_url/Pages/More/blogPost.dart';
import 'package:test_url/Setting/numbers.dart';
import 'package:test_url/Setting/platform.dart';
import 'package:test_url/Setting/strings.dart';
import 'package:test_url/Styles/animations.dart';
import 'package:test_url/providers/MorePageProviders/blogProvider.dart';
import 'package:provider/provider.dart';

class Blog extends StatefulWidget {
  final int postId;
  final int _pageIndex;

  Blog(this._pageIndex, {this.postId});

  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  final _scrollController = ScrollController();
  Future blogData;
  final int postPerPage = 5;

  _getBlogData() async {
    return await Provider.of<BlogProvider>(context, listen: false).fetchBlog();
  }

  @override
  void initState() {
    super.initState();
    blogData = _getBlogData();
    if (widget.postId != null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => pushNewScreenWithRouteSettings(
          context,
          settings: null,
          screen: BlogPost(widget.postId),
          pageTransitionAnimation: changePageAnimation,
        ),
      );
    }
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
                blogPageTitle,
                style: theme.textTheme.headline5,
              ),
            )
          : AppBar(
              title: Text(blogPageTitle),
              centerTitle: true,
              textTheme: theme.textTheme,
            ),
      backgroundColor: theme.backgroundColor,
      body: FutureBuilder(
          future: blogData,
          builder: (ctx, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return CustomIndicator();
            } else {
              if (snapShot.hasError) {
                return CustomErrorWidget();
              } else {
                return Scrollbar(
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
                      child: Consumer<BlogProvider>(
                        builder: (ctx, data, child) => Column(
                          children: [
                            ...((widget._pageIndex + 1) * postPerPage <
                                        data.blogs.length
                                    ? data.blogs.sublist(
                                            widget._pageIndex * postPerPage,
                                            (widget._pageIndex + 1) *
                                                postPerPage)
                                        as List<Map<String, Object>>
                                    : data.blogs.sublist(
                                            widget._pageIndex * postPerPage,
                                            data.blogs.length)
                                        as List<Map<String, Object>>)
                                .map((item) {
                              return BlogPostElement(
                                item['id'],
                                item['title'],
                                item['image'],
                                getBlogPostDate(item['create_time']),
                                getBlogPostTime(item['create_time']),
                              );
                            }).toList(),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomRaisedButton(
                                    onPressed: () => {
                                      pushNewScreenWithRouteSettings(
                                        context,
                                        settings: null,
                                        screen: Blog(widget._pageIndex - 1),
                                        pageTransitionAnimation:
                                            changePageAnimation,
                                      )
                                    },
                                    title: blogPreviousPage,
                                    isDisabled:
                                        widget._pageIndex <= 0 ? true : false,
                                  ),
                                  Text(
                                    blogPages +
                                        (widget._pageIndex + 1).toString(),
                                    style: theme.textTheme.headline5,
                                  ),
                                  CustomRaisedButton(
                                    onPressed: () => {
                                      pushNewScreenWithRouteSettings(
                                        context,
                                        settings: null,
                                        screen: Blog(widget._pageIndex + 1),
                                        pageTransitionAnimation:
                                            changePageAnimation,
                                      ),
                                    },
                                    title: blogNextPage,
                                    isDisabled: widget._pageIndex ==
                                                (data.blogs.length /
                                                        postPerPage)
                                                    .round() ||
                                            (widget._pageIndex + 1) *
                                                    postPerPage ==
                                                data.blogs.length
                                        ? true
                                        : false,
                                  ),
                                ],
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
          }),
    );
  }
}

//TODO: implement share button
