import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_url/Pages/customErrorWidget.dart';
import 'package:test_url/Components/customIndicator.dart';
import 'package:test_url/Components/MoreRoute/moreTextElement.dart';
import 'package:test_url/Setting/numbers.dart';
import 'package:test_url/Setting/platform.dart';
import 'package:test_url/Setting/strings.dart';
import 'package:test_url/Styles/icons.dart';
import 'package:test_url/providers/MorePageProviders/contactUsProvider.dart';
import 'package:provider/provider.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _scrollController = ScrollController();
  Future contactdata;

  @override
  void initState() {
    super.initState();
    contactdata = _getContactData();
  }

  _getContactData() async {
    return await Provider.of<ContactUsProvider>(context, listen: false)
        .fetchContactUs();
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
                contactUsPageTitle,
                style: theme.textTheme.headline5,
              ),
            )
          : AppBar(
              title: Text(contactUsPageTitle),
              centerTitle: true,
              textTheme: theme.textTheme,
            ),
      backgroundColor: theme.backgroundColor,
      body: FutureBuilder(
          future: contactdata,
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
                    child: Consumer<ContactUsProvider>(
                      builder: (ctx, data, child) => Container(
                        margin: EdgeInsets.only(
                          top: pagesTopMargin,
                          bottom: pagesBottomMargin,
                          left: pagesRightAndLeftMargin(_width, _mobileView),
                          right: pagesRightAndLeftMargin(_width, _mobileView),
                        ),
                        child: Column(
                          children: [
                            ...(data.contactUs as List<Map<String, Object>>)
                                .map((item) {
                              return MoreTextElement(
                                item,
                                'question',
                                'answer',
                                contactUsIcon,
                              );
                            }).toList(),
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
