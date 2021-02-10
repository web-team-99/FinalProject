import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:test_url/Enums/homeOptionsEnum.dart';
import 'package:test_url/Enums/mainTabsEnum.dart';
import 'package:test_url/Enums/moreOptionsEnum.dart';
import 'package:test_url/Functions/mainFunctions.dart';
import 'package:test_url/Routes/homeRoute.dart';
import 'package:test_url/Routes/messagesRoute.dart';
import 'package:test_url/Routes/moreRoute.dart';
import 'package:test_url/Routes/profileRoute.dart';
import 'package:test_url/Routes/searchRoute.dart';
import 'package:test_url/Setting/platform.dart';
import 'package:test_url/Styles/icons.dart';
import 'package:test_url/Styles/themes.dart';
import 'package:test_url/providers/MorePageProviders/aboutUsProvider.dart';
import 'package:test_url/providers/MorePageProviders/blogPostProvider.dart';
import 'package:test_url/providers/MorePageProviders/blogProvider.dart';
import 'package:test_url/providers/MorePageProviders/contactUsProvider.dart';
import 'package:test_url/providers/MorePageProviders/faqProvider.dart';
import 'package:test_url/providers/MorePageProviders/manualProvider.dart';
import 'package:test_url/providers/MorePageProviders/pricingProvider.dart';
import 'package:test_url/providers/MorePageProviders/rulesProvider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final MainTab initialTab;
  final MoreOption moreOption;
  final HomeOption homeOption;
  final int id;

  MainScreen(
      {@required this.initialTab, this.moreOption, this.homeOption, this.id});

  State<StatefulWidget> createState() {
    return _MainScreenState(
      initialTab,
      moreOption,
      homeOption,
      id,
    );
  }
}

class _MainScreenState extends State<MainScreen> {
  PersistentTabController _controller;
  // bool _hideNavBar;
  final MainTab _initialTab;
  final MoreOption _moreOption;
  final HomeOption _homeOption;
  final int _id;

  _MainScreenState(
    this._initialTab,
    this._moreOption,
    this._homeOption,
    this._id,
  );

  @override
  void initState() {
    super.initState();
    _controller =
        PersistentTabController(initialIndex: getInitialIndex(_initialTab));
    // _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
      HomeRoute(),
      MessagesRoute(),
      SearchRoute(),
      ProfileRoute(),
      MoreRoute(_moreOption, _id),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    ThemeData theme = Theme.of(context);
    return [
      PersistentBottomNavBarItem(
        icon: Icon(homeIcon),
        // title: homePageTitle,
        activeColor: isOnIos ? theme.primaryColor : theme.backgroundColor,
        inactiveColor: Colors.grey,
        // titleStyle: TextStyle(fontFamily: mainFontFamily),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(messagesIcon),
        // title: (messagesPageTitle),
        activeColor: isOnIos ? theme.primaryColor : theme.backgroundColor,
        inactiveColor: Colors.grey,
        // titleStyle: TextStyle(fontFamily: mainFontFamily),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(searchIcon),
        // title: (searchPageTitle),
        activeColor: isOnIos ? theme.primaryColor : theme.backgroundColor,
        inactiveColor: Colors.grey,
        // titleStyle: TextStyle(fontFamily: mainFontFamily),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(profileIcon),
        // title: (profilePageTitle),
        activeColor: isOnIos ? theme.primaryColor : theme.backgroundColor,
        inactiveColor: Colors.grey,
        // titleStyle: TextStyle(fontFamily: mainFontFamily),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(moreIcon),
        // title: (morePageTitle),
        activeColor: isOnIos ? theme.primaryColor : theme.backgroundColor,
        inactiveColor: Colors.grey,
        // titleStyle: TextStyle(fontFamily: mainFontFamily),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AboutUsProvider()),
        ChangeNotifierProvider.value(value: ContactUsProvider()),
        ChangeNotifierProvider.value(value: FaqProvider()),
        ChangeNotifierProvider.value(value: ManualProvider()),
        ChangeNotifierProvider.value(value: PricingProvider()),
        ChangeNotifierProvider.value(value: RuleProvider()),
        ChangeNotifierProvider.value(value: BlogProvider()),
        ChangeNotifierProvider.value(value: BlogPostProvider()),
      ],
      child: MaterialApp(
        theme: defaultTheme,
        home: Scaffold(
          body: PersistentTabView(
            controller: _controller,
            screens: _buildScreens(),
            confineInSafeArea: true,

            itemCount: 5,
            backgroundColor: isOnIos
                ? Color.fromRGBO(248, 248, 248, 1)
                : Color.fromRGBO(43, 45, 66, 1),
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            hideNavigationBarWhenKeyboardShows: true,
            // hideNavigationBar: _hideNavBar,
            decoration: NavBarDecoration(
              colorBehindNavBar: Theme.of(context).backgroundColor,
              boxShadow: isOnIos
                  ? null
                  : [
                      BoxShadow(
                        color: Color.fromRGBO(43, 45, 66, 1),
                        offset: Offset(0.0, -2.0),
                        blurRadius: 5.0,
                      ),
                    ],
            ),
            popAllScreensOnTapOfSelectedTab: true,
            itemAnimationProperties: ItemAnimationProperties(
              duration: Duration(milliseconds: 400),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 400),
            ),
            items: _navBarsItems(),
            navBarStyle: NavBarStyle.style14,
          ),
        ),
      ),
    );
  }
}
