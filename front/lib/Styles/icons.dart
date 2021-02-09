import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_url/Setting/platform.dart';

//navigationBar tabs
IconData homeIcon = isOnIos ? CupertinoIcons.house : Icons.home;
IconData messagesIcon = isOnIos ? CupertinoIcons.envelope : Icons.message;
IconData searchIcon = isOnIos ? CupertinoIcons.search : Icons.search;
IconData profileIcon = isOnIos ? CupertinoIcons.profile_circled : Icons.person;
IconData moreIcon = isOnIos ? CupertinoIcons.ellipsis : Icons.more_horiz;

//Home Route
IconData viewMoreProjectsAndServicesIcon = Icons.read_more;

//More Route
IconData aboutUsIcon = isOnIos ? CupertinoIcons.info : Icons.info;
IconData contactUsIcon = isOnIos ? CupertinoIcons.phone : Icons.contact_phone;
IconData pricingsIcon = isOnIos ? CupertinoIcons.money_dollar : Icons.money;
IconData rulesIcon = isOnIos ? CupertinoIcons.text_badge_checkmark : Icons.rule;
IconData faqIcon = isOnIos ? CupertinoIcons.question : Icons.help;
IconData manualIcon =
    isOnIos ? CupertinoIcons.square_list : Icons.integration_instructions;
IconData blogIcon =
    isOnIos ? CupertinoIcons.list_bullet_below_rectangle : Icons.web;
IconData softWareTeamIcon = CupertinoIcons.chevron_left_slash_chevron_right;
IconData blogDateIcon =
    isOnIos ? CupertinoIcons.calendar : Icons.calendar_today;
IconData blogTimeIcon = isOnIos ? CupertinoIcons.clock : Icons.access_time;
IconData manualExpansionIcon = Icons.expand_more;
IconData blogLinkCopiedIcon =
    isOnIos ? CupertinoIcons.checkmark_alt_circle : Icons.check;
IconData blogShareIcon = isOnIos ? CupertinoIcons.share : Icons.share;

//other icons
IconData errorIcon =
    isOnIos ? CupertinoIcons.exclamationmark_square : Icons.error;
IconData networkErrorIcon =
    isOnIos ? CupertinoIcons.wifi_slash : Icons.signal_wifi_off;
