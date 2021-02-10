import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_url/Enums/moreOptionsEnum.dart';
import 'package:test_url/Pages/More/aboutUs.dart';
import 'package:test_url/Pages/More/blog.dart';
import 'package:test_url/Pages/More/contactUs.dart';
import 'package:test_url/Pages/More/faq.dart';
import 'package:test_url/Pages/More/manual.dart';
import 'package:test_url/Pages/More/pricings.dart';
import 'package:test_url/Pages/More/rules.dart';
import 'package:test_url/Pages/More/softwareTeam.dart';
import 'package:test_url/Setting/strings.dart';
import 'package:test_url/Styles/icons.dart';

IconData getIcon(moreOption) {
  switch (moreOption) {
    case MoreOption.aboutUs:
      return aboutUsIcon;
      break;
    case MoreOption.contactUs:
      return contactUsIcon;
      break;
    case MoreOption.faq:
      return faqIcon;
      break;
    case MoreOption.rules:
      return rulesIcon;
      break;
    case MoreOption.pricings:
      return pricingsIcon;
      break;
    case MoreOption.manual:
      return manualIcon;
      break;
    case MoreOption.blog:
      return blogIcon;
      break;
    case MoreOption.softWareTeam:
      return softWareTeamIcon;
      break;
    default:
      return aboutUsIcon;
  }
}

String getText(moreOption) {
  switch (moreOption) {
    case MoreOption.aboutUs:
      return aboutUsPageTitle;
      break;
    case MoreOption.contactUs:
      return contactUsPageTitle;
      break;
    case MoreOption.faq:
      return faqPageTitle;
      break;
    case MoreOption.rules:
      return rulesPageTitle;
      break;
    case MoreOption.pricings:
      return pricingsPageTitle;
      break;
    case MoreOption.manual:
      return manualPageTitle;
      break;
    case MoreOption.blog:
      return blogPageTitle;
      break;
    case MoreOption.softWareTeam:
      return softwareTeamPageTitle;
      break;
    default:
      return aboutUsPageTitle;
  }
}

Widget getScreen(moreOption, {blogPostId}) {
  switch (moreOption) {
    case MoreOption.aboutUs:
      return AboutUs();
      break;
    case MoreOption.contactUs:
      return ContactUs();
      break;
    case MoreOption.faq:
      return Faq();
      break;
    case MoreOption.rules:
      return Rules();
      break;
    case MoreOption.pricings:
      return Pricings();
      break;
    case MoreOption.manual:
      return Manual();
      break;
    case MoreOption.blog:
      return Blog(0);
      break;
    case MoreOption.softWareTeam:
      return SoftwareTeam();
      break;
    default:
      return AboutUs();
  }
}

String getBlogPostDate(String dateTime) {
  //  "1399-09-10T07:43:39.022775+00:00"
  String englishDate = dateTime.split('-')[1] +
      '/' +
      dateTime.split('-')[2].substring(0, 2) +
      '/' +
      dateTime.split('-')[0];

  return englishDate;
}

String getBlogPostTime(String dateTime) {
  String englishTime = dateTime.split('T')[1].substring(0, 5);
  return englishTime;
}
