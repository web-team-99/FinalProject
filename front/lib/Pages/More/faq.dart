import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_url/Components/MoreRoute/faqWidget.dart';
import 'package:test_url/Pages/customErrorWidget.dart';
import 'package:test_url/Components/customIndicator.dart';
import 'package:test_url/Setting/numbers.dart';
import 'package:test_url/Setting/platform.dart';
import 'package:test_url/Setting/strings.dart';
import 'package:test_url/providers/MorePageProviders/faqProvider.dart';
import 'package:provider/provider.dart';

class Faq extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<Faq> {
  final _scrollController = ScrollController();
  Future faqData;

  @override
  void initState() {
    super.initState();
    faqData = _getFAQData();
  }

  _getFAQData() async {
    return await Provider.of<FaqProvider>(context, listen: false).fetchFaq();
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
                faqPageTitle,
                style: theme.textTheme.headline5,
              ),
            )
          : AppBar(
              title: Text(faqPageTitle),
              centerTitle: true,
              textTheme: theme.textTheme,
            ),
      backgroundColor: theme.backgroundColor,
      body: FutureBuilder(
          future: faqData,
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
                    child: Consumer<FaqProvider>(
                      builder: (ctx, data, child) => Container(
                        margin: EdgeInsets.only(
                          top: pagesTopMargin,
                          bottom: pagesBottomMargin,
                          left: pagesRightAndLeftMargin(_width, _mobileView),
                          right: pagesRightAndLeftMargin(_width, _mobileView),
                        ),
                        child: Column(
                          children: [
                            ...(data.faq as List<Map<String, Object>>)
                                .map((item) {
                              return FaqWidget(
                                item,
                                'question',
                                'answer',
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
