import 'package:flutter/material.dart';
import 'package:test_url/Setting/numbers.dart';
import 'package:test_url/Setting/serverUrl.dart';
import 'package:test_url/Setting/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class WebDesktopHomeFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    bool _mobileView = _width < mobileViewMaxWidth ? true : false;
    ThemeData theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                width: _width / 10,
                child: Image.asset('assets/logo.png'),
              ),
              Text(
                companyName,
                style: theme.textTheme.bodyText1,
              ),
              Text(
                allRightsReserved,
                style: theme.textTheme.bodyText1,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text(
                  faqPageTitle,
                  style: theme.textTheme.bodyText1,
                ),
                onPressed: () => _launchURL(faqUrl),
              ),
              RaisedButton(
                child: Text(
                  manualPageTitle,
                  style: theme.textTheme.bodyText1,
                ),
                onPressed: () => _launchURL(manualUrl),
              ),
              RaisedButton(
                child: Text(
                  blogPageTitle,
                  style: theme.textTheme.bodyText1,
                ),
                onPressed: () => _launchURL(blogUrl),
              ),
              RaisedButton(
                child: Text(
                  softwareTeamPageTitle,
                  style: theme.textTheme.bodyText1,
                ),
                onPressed: () => _launchURL(softwareTeamUrl),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text(
                  aboutUsPageTitle,
                  style: theme.textTheme.bodyText1,
                ),
                onPressed: () => _launchURL(aboutUsUrl),
              ),
              RaisedButton(
                child: Text(
                  contactUsPageTitle,
                  style: theme.textTheme.bodyText1,
                ),
                onPressed: () => _launchURL(contactUsUrl),
              ),
              RaisedButton(
                child: Text(
                  pricingsPageTitle,
                  style: theme.textTheme.bodyText1,
                ),
                onPressed: () => _launchURL(pricingsUrl),
              ),
              RaisedButton(
                child: Text(
                  rulesPageTitle,
                  style: theme.textTheme.bodyText1,
                ),
                onPressed: () => _launchURL(rulesUrl),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
