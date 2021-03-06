import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:test_url/Components/CustomRaisedButton.dart';
import 'package:test_url/Components/HomeRoute/ProjectAndServiceSuggest.dart';
import 'package:test_url/Components/HomeRoute/homeListHeader.dart';
import 'package:test_url/Components/HomeRoute/webDesktopHomeFooter.dart';
import 'package:test_url/Components/HomeRoute/webDesktopHomeImageAndText.dart';
import 'package:test_url/Components/HomeRoute/webMobileHomeFooter.dart';
import 'package:test_url/Components/HomeRoute/webMobileHomeImageAndText.dart';
import 'package:test_url/Components/customIndicator.dart';
import 'package:test_url/Pages/customErrorWidget.dart';
import 'package:test_url/Pages/moreProjects.dart';
import 'package:test_url/Setting/numbers.dart';
import 'package:test_url/Setting/platform.dart';
import 'package:test_url/Setting/strings.dart';
import 'package:test_url/Styles/animations.dart';
import 'package:test_url/providers/ProjectsProvider.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  final _scrollController = ScrollController();
  Future suggestionData;

  @override
  void initState() {
    suggestionData = _getData();
    super.initState();
  }

  _getData() async {
    return await Provider.of<ProjectsProvider>(context, listen: false)
        .fetchProjects();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    bool _mobileView = _width < mobileViewMaxWidth ? true : false;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: isOnWeb
          ? AppBar(
              actions: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: CustomRaisedButton(
                    title: homePageAppBarInstallApp,
                    onPressed: () => {
                      //TODO
                    },
                  ),
                )
              ],
              title: Text(homePageTitle),
              centerTitle: true,
              textTheme: theme.textTheme,
            )
          : isOnIos
              ? CupertinoNavigationBar(
                  middle: Text(
                    homePageTitle,
                    style: theme.textTheme.headline5,
                  ),
                )
              : AppBar(
                  title: Text(homePageTitle),
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
              top: pagesTopMargin,
              bottom: pagesBottomMargin,
              left: homePageRightAndLeftMargin(_width, _mobileView),
              right: homePageRightAndLeftMargin(_width, _mobileView),
            ),
            child: Column(
              children: [
                isOnWeb
                    ? _mobileView
                        ? WebMobileHomeImageAndText(
                            homeFirstStringTitle,
                            homeFirstStringDescription,
                            'assets/homeOne.png',
                          )
                        : WebDesktopHomeImageAndText(
                            homeFirstStringTitle,
                            homeFirstStringDescription,
                            'assets/homeOne.png',
                          )
                    : SizedBox.shrink(),
                isOnWeb
                    ? _mobileView
                        ? WebMobileHomeImageAndText(
                            homeSecondStringTitle,
                            homeSecondStringDescription,
                            'assets/homeTwo.png',
                          )
                        : WebDesktopHomeImageAndText(
                            homeSecondStringTitle,
                            homeSecondStringDescription,
                            'assets/homeTwo.png',
                          )
                    : SizedBox.shrink(),
                HomeListHeader(
                  projectsHeader,
                  () => {
                    
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 175,
                  child: FutureBuilder(
                    future: suggestionData,
                    builder: (ctx, snapShot) {
                      if (snapShot.connectionState == ConnectionState.waiting) {
                        return CustomIndicator();
                      }
                      if (snapShot.hasError) {
                        return CustomErrorWidget();
                      }
                      return Consumer<ProjectsProvider>(
                          builder: (ctx, d, child) {
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) =>
                                ProjectAndServiceSuggest(
                                  d.projects[index].title,
                                  d.projects[index].shortDescription,
                                  d.projects[index].price,
                                  d.projects[index].id,
                                ));
                      });
                    },
                  ),
                ),
                HomeListHeader(
                  servicesHeader,
                  () => {
                    pushNewScreenWithRouteSettings(
                      context,
                      settings: null,
                      screen: MoreProjects(),
                      pageTransitionAnimation: changePageAnimation,
                    )
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 175,
                  child: FutureBuilder(
                    future: suggestionData,
                    builder: (ctx, snapShot) {
                      if (snapShot.connectionState == ConnectionState.waiting) {
                        return CustomIndicator();
                      }
                      if (snapShot.hasError) {
                        return CustomErrorWidget();
                      }
                      return Consumer<ProjectsProvider>(
                          builder: (ctx, d, child) {
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) =>
                                ProjectAndServiceSuggest(
                                  d.projects[index].title,
                                  d.projects[index].shortDescription,
                                  d.projects[index].price,
                                  d.projects[index].id,
                                ));
                      });
                    },
                  ),
                ),
                isOnWeb
                    ? Divider(
                        height: 100,
                        thickness: 3,
                      )
                    : SizedBox.shrink(),
                Card(
                  child: isOnWeb
                      ? _mobileView
                          ? WebMobileHomeFooter()
                          : WebDesktopHomeFooter()
                      : SizedBox.shrink(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
