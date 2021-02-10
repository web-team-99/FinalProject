import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:test_url/Enums/mainTabsEnum.dart';
import 'package:test_url/Enums/moreOptionsEnum.dart';
import 'package:test_url/Routes/mainScreen.dart';
import 'package:test_url/Setting/serverUrl.dart';

class FluroMainRouter {
  static var router = FluroRouter();

  static getMainTabHandler(MainTab mainTab) {
    return Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return MainScreen(
        initialTab: mainTab,
      );
    });
  }

  static getMoreOptionHandler(MoreOption moreOption) {
    return Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return MainScreen(
        initialTab: MainTab.more,
        moreOption: moreOption,
      );
    });
  }

  static var blogHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return MainScreen(
      initialTab: MainTab.more,
      moreOption: MoreOption.blog,
      id: int.parse(params['id'][0]),
    );
  });

  static void defineRoutes() {
    //main tabs
    router.define(homeRouteString, handler: getMainTabHandler(MainTab.home));
    router.define(messagesRouteString,
        handler: getMainTabHandler(MainTab.messages));
    router.define(searchRouteString,
        handler: getMainTabHandler(MainTab.search));
    router.define(profileRouteString,
        handler: getMainTabHandler(MainTab.profile));
    router.define(moreRouteString, handler: getMainTabHandler(MainTab.more));

    //more options

    router.define(
      aboutUsRouteString,
      handler: getMoreOptionHandler(MoreOption.aboutUs),
    );
    router.define(
      contactUsRouteString,
      handler: getMoreOptionHandler(MoreOption.contactUs),
    );
    router.define(
      pricingRouteString,
      handler: getMoreOptionHandler(MoreOption.pricings),
    );
    router.define(
      rulesRouteString,
      handler: getMoreOptionHandler(MoreOption.rules),
    );
    router.define(
      faqRouteString,
      handler: getMoreOptionHandler(MoreOption.faq),
    );
    router.define(
      manualRouteString,
      handler: getMoreOptionHandler(MoreOption.manual),
    );
    router.define(
      blogRouteString,
      handler: getMoreOptionHandler(MoreOption.blog),
    );
    router.define(
      softwareTeamRouteString,
      handler: getMoreOptionHandler(MoreOption.softWareTeam),
    );

    //blog post
    router.define(blogRouteString + '/:id', handler: blogHandler);

    // it is also possible to define the route transition to use
    // router.define('users/:id', handler: usersHandler, transitionType: TransitionType.inFromLeft);
  }
}
