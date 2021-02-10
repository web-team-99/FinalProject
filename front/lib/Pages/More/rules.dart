import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_url/Pages/customErrorWidget.dart';
import 'package:test_url/Components/customIndicator.dart';
import 'package:test_url/Components/MoreRoute/moreTextElement.dart';
import 'package:test_url/Setting/numbers.dart';
import 'package:test_url/Setting/platform.dart';
import 'package:test_url/Setting/strings.dart';
import 'package:test_url/Styles/icons.dart';
import 'package:test_url/providers/MorePageProviders/rulesProvider.dart';
import 'package:provider/provider.dart';

class Rules extends StatefulWidget {
  @override
  _RulesState createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  final _scrollController = ScrollController();
  Future rulesData;

  @override
  void initState() {
    super.initState();
    rulesData = _getRulesData();
  }

  _getRulesData() async {
    return await Provider.of<RuleProvider>(context, listen: false).fetchRules();
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
                rulesPageTitle,
                style: theme.textTheme.headline5,
              ),
            )
          : AppBar(
              title: Text(rulesPageTitle),
              centerTitle: true,
              textTheme: theme.textTheme,
            ),
      backgroundColor: theme.backgroundColor,
      body: FutureBuilder(
          future: rulesData,
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
                      child: Consumer<RuleProvider>(
                        builder: (ctx, data, child) => Container(
                          child: Column(
                            children: [
                              ...(data.rules as List<Map<String, Object>>)
                                  .map((item) {
                                return MoreTextElement(
                                  item,
                                  'question',
                                  'answer',
                                  rulesIcon,
                                );
                              }).toList(),
                            ],
                          ),
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
