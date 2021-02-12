import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_url/Components/CustomRaisedButton.dart';
import 'package:test_url/Components/HomeRoute/ProjectAndServiceSuggest.dart';
import 'package:test_url/Components/HomeRoute/homeListHeader.dart';
import 'package:test_url/Components/HomeRoute/webDesktopHomeFooter.dart';
import 'package:test_url/Components/HomeRoute/webDesktopHomeImageAndText.dart';
import 'package:test_url/Components/HomeRoute/webMobileHomeFooter.dart';
import 'package:test_url/Components/HomeRoute/webMobileHomeImageAndText.dart';
import 'package:test_url/Cubits/InternetStateCubit.dart';
import 'package:test_url/Pages/CustomDialog.dart';
import 'package:test_url/Setting/numbers.dart';
import 'package:test_url/Setting/platform.dart';
import 'package:test_url/Setting/strings.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> with TickerProviderStateMixin {
  final _scrollController = ScrollController();

  TabController _tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    _tabController =
        TabController(initialIndex: _tabIndex, length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    bool _mobileView = _width < mobileViewMaxWidth ? true : false;
    ThemeData theme = Theme.of(context);

    return createTabs(context, theme);
    // return Scaffold(
    //     appBar: isOnWeb
    //         ? AppBar(
    //             actions: [
    //               Container(
    //                 margin: EdgeInsets.all(10),
    //                 child: CustomRaisedButton(
    //                   title: homePageAppBarInstallApp,
    //                   onPressed: () => {
    //                     //TODO
    //                   },
    //                 ),
    //               )
    //             ],
    //             title: Text(homePageTitle),
    //             centerTitle: true,
    //             textTheme: theme.textTheme,
    //           )
    //         : isOnIos
    //             ? CupertinoNavigationBar(
    //                 middle: Text(
    //                   homePageTitle,
    //                   style: theme.textTheme.headline5,
    //                 ),
    //               )
    //             : AppBar(
    //                 title: Text(homePageTitle),
    //                 centerTitle: true,
    //                 textTheme: theme.textTheme,
    //               ),
    //     backgroundColor: theme.backgroundColor,
    //     body: Scrollbar(
    //         controller: _scrollController,
    //         isAlwaysShown: true,
    //         child: SingleChildScrollView(
    //           controller: _scrollController,
    //           child: Container(
    //             alignment: Alignment.center,
    //             margin: EdgeInsets.only(
    //               top: pagesTopMargin,
    //               bottom: pagesBottomMargin,
    //               left: homePageRightAndLeftMargin(_width, _mobileView),
    //               right: homePageRightAndLeftMargin(_width, _mobileView),
    //             ),
    //             child: BlocBuilder<InternetCubit, InternetState>(
    //                 builder: (context, state) {
    //               if (state is InternetDisconnected) {
    //                 return CustomDialog(
    //                   title: "Disconnected",
    //                   description:
    //                       "You are disconnected from the server.\nPlease check your connection status.",
    //                   buttonText: "confirm",
    //                 );
    //               }
    //               return Column(
    //                 children: [
    //                   isOnWeb
    //                       ? _mobileView
    //                           ? WebMobileHomeImageAndText(
    //                               homeFirstStringTitle,
    //                               homeFirstStringDescription,
    //                               'assets/homeOne.png',
    //                             )
    //                           : WebDesktopHomeImageAndText(
    //                               homeFirstStringTitle,
    //                               homeFirstStringDescription,
    //                               'assets/homeOne.png',
    //                             )
    //                       : SizedBox.shrink(),
    //                   isOnWeb
    //                       ? _mobileView
    //                           ? WebMobileHomeImageAndText(
    //                               homeSecondStringTitle,
    //                               homeSecondStringDescription,
    //                               'assets/homeTwo.png',
    //                             )
    //                           : WebDesktopHomeImageAndText(
    //                               homeSecondStringTitle,
    //                               homeSecondStringDescription,
    //                               'assets/homeTwo.png',
    //                             )
    //                       : SizedBox.shrink(),
    // createTabs(context),
    // HomeListHeader(
    //   projectsHeader,
    //   () => {
    //     //TODO
    //   },
    // ),
    // Container(
    //   margin: EdgeInsets.symmetric(vertical: 20.0),
    //   height: 175,
    //   child: ListView.builder(
    //     shrinkWrap: true,
    //     scrollDirection: Axis.horizontal,
    //     itemCount: 5,
    //     itemBuilder: (BuildContext context, int index) =>
    //         ProjectAndServiceSuggest(
    //       'http://138.201.6.240:8001/media/blog_photos/increase-virgool.jpg',
    //       30,
    //       'sample project',
    //     ),
    //   ),
    // ),
    // HomeListHeader(
    //   servicesHeader,
    //   () => {
    //     //TODO
    //   },
    // ),
    // Container(
    //   margin: EdgeInsets.symmetric(vertical: 20.0),
    //   height: 175,
    //   child: ListView.builder(
    //     shrinkWrap: true,
    //     scrollDirection: Axis.horizontal,
    //     itemCount: 5,
    //     itemBuilder: (BuildContext context, int index) =>
    //         ProjectAndServiceSuggest(
    //       'http://138.201.6.240:8001/media/blog_photos/omid4.jpg',
    //       100,
    //       'sample service',
    //     ),
    //   ),
    // ),
    //           isOnWeb
    //               ? Divider(
    //                   height: 100,
    //                   thickness: 3,
    //                 )
    //               : SizedBox.shrink(),
    //           Card(
    //             child: isOnWeb
    //                 ? _mobileView
    //                     ? WebMobileHomeFooter()
    //                     : WebDesktopHomeFooter()
    //                 : SizedBox.shrink(),
    //           )
    //         ],
    //       );
    //     }),
    //   ),
    // )));
  }

  Widget createTabs(BuildContext context, ThemeData theme) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: _tabIndex == 0
            ? theme.appBarTheme.backgroundColor
            : theme.primaryColor,
        title: Align(alignment: Alignment.center, child: Text("Freelance")),
        bottom: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: Colors.white,
          labelStyle:
              TextStyle(color: Colors.blueGrey, fontSize: 18, fontWeight: FontWeight.w500),
          labelColor: theme.appBarTheme.backgroundColor,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(color: Colors.black12,
                offset: Offset(0.0, 1.0),
                ),
                BoxShadow(
                    color: Colors.white,
                    spreadRadius: -1.0,
                    blurRadius: 1.0,
                    offset: Offset(0.0, 2.8)
                  ),
              ]),
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
          tabs: [
            Tab(
              text: "Projects",
            ),
            Tab(
              text: "Services",
            ),
          ],
        ),
      ),
      body: createBody(context),
    );
  }

  Widget createBody(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        if (state is InternetDisconnected) {
          return Center(
            child: CustomDialog(
              title: "Disconnected",
              description:
                  "You are disconnected from the server.\nPlease check your connection status.",
            ),
          );
        }
        return TabBarView(
            controller: _tabController,
            children: [Icon(Icons.car_repair), Icon(Icons.movie)]);
      },
    );
  }
}
