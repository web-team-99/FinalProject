import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_url/Pages/customErrorWidget.dart';
import 'package:test_url/Components/customIndicator.dart';
import 'package:test_url/Components/MoreRoute/pricingsWidget.dart';
import 'package:test_url/Setting/numbers.dart';
import 'package:test_url/Setting/platform.dart';
import 'package:test_url/Setting/strings.dart';
import 'package:test_url/providers/MorePageProviders/pricingProvider.dart';
import 'package:provider/provider.dart';

class Pricings extends StatefulWidget {
  @override
  _PricingsState createState() => _PricingsState();
}

class _PricingsState extends State<Pricings> {
  final _scrollController = ScrollController();
  Future pricingsData;

  @override
  void initState() {
    super.initState();
    pricingsData = _getPricingsData();
  }

  _getPricingsData() async {
    return await Provider.of<PricingProvider>(context, listen: false)
        .fetchPricings();
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
                pricingsPageTitle,
                style: theme.textTheme.headline5,
              ),
            )
          : AppBar(
              title: Text(pricingsPageTitle),
              centerTitle: true,
              textTheme: theme.textTheme,
            ),
      backgroundColor: theme.backgroundColor,
      body: FutureBuilder(
        future: pricingsData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CustomIndicator();
          if (snapshot.hasError) return CustomErrorWidget();
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
                child: Consumer<PricingProvider>(
                  builder: (context, data, child) => Column(
                    children: [
                      ...data.pricings
                          .map(
                            (e) => PricingsWidget(
                              pricingModel: e,
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
