import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:test_url/Components/no_paint_rounded_border.dart';
import 'package:test_url/Cubits/InternetStateCubit.dart';
import 'package:test_url/Pages/CustomDialog.dart';

import 'package:test_url/Setting/numbers.dart';
import 'package:test_url/Setting/platform.dart';
import 'package:test_url/Setting/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectServiceRoute extends StatefulWidget {
  @override
  _ProjectServiceRouteState createState() => _ProjectServiceRouteState();
}

class _ProjectServiceRouteState extends State<ProjectServiceRoute>
    with TickerProviderStateMixin {
  // final _scrollController = ScrollController();
  double _width;
  double _height;
  bool _mobileView;

  ScrollController _scrollViewController;
  bool isScrolledDown = false;
  bool showAppbar = true;

  TabController _tabController;
  TextEditingController titleController = TextEditingController();
  TextEditingController briefDescController = TextEditingController();
  TextEditingController fullDescController = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    _scrollViewController = new ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrolledDown) {
          isScrolledDown = true;
          showAppbar = false;
          setState(() {});
        }
      }
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrolledDown) {
          isScrolledDown = false;
          showAppbar = true;
          setState(() {});
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    _mobileView = _width < mobileViewMaxWidth ? true : false;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: isOnIos
          ? CupertinoNavigationBar(
              middle: Text(
                projectsAndServicesPageTitle,
                style: theme.textTheme.headline5,
              ),
            )
          // : AppBar(
          //     title: Text(
          //       projectsAndServicesPageTitle,
          //     ),
          //     centerTitle: true,
          //     textTheme: theme.textTheme,
          //     bottom: TabBar(
          //       controller: _tabController,
          //       tabs: [
          //         Tab(
          //           text: "Your Projects",
          //         ),
          //         Tab(
          //           text: "Your Services",
          //         ),
          //       ],
          //     ),
          //   ),
          : PreferredSize(child: AppBar(), preferredSize: Size.fromHeight(0.0)),
      backgroundColor: theme.primaryColor,
      body: createBody(context, theme),
    );
  }

  Widget createBody(BuildContext context, ThemeData theme) {
    // return Scrollbar(
    //   controller: _scrollController,
    //   isAlwaysShown: true,
    //   child: SingleChildScrollView(
    //     controller: _scrollController,
    //     child: Container(
    //       alignment: Alignment.center,
    //       margin: EdgeInsets.only(
    //         bottom: pagesBottomMargin,
    //         left: pagesRightAndLeftMargin(_width, _mobileView),
    //         right: pagesRightAndLeftMargin(_width, _mobileView),
    //       ),
    //       child: BlocBuilder<InternetCubit, InternetState>(
    //           builder: (context, state) {
    //         if (state is InternetDisconnected) {
    //           return CustomDialog(
    //             title: "Disconnected",
    //             description:
    //                 "You are disconnected from the server.\nPlease check your connection status.",
    //           );
    //         }
    //         return Column(
    //           children: [],
    //         );
    //       }),
    //     ),
    //   ),
    // );
    return Scrollbar(
      controller: _scrollViewController,
      child: SingleChildScrollView(
        controller: _scrollViewController,
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(top: 20.0, left: 15.0),
              child: Text(
                'Add a new Project...',
                style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: _height * 0.4,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              width: double.infinity,
              color: theme.primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  createTextField(label: 'Title', controller: titleController),
                  createTextField(
                      label: 'Brief Description',
                      controller: briefDescController),
                  createTextField(
                      label: 'Full Description',
                      controller: fullDescController),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                      child: Text(
                        'Create',
                        style: TextStyle(fontSize: 18, color: theme.primaryColor),
                      ),
                      onPressed: () => {},
                    ),
                  )
                ],
              ),
            ),

            // Expanded(
            //   child: SingleChildScrollView(
            Container(
              height: _height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white),
            ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget createTextField({
    String label,
    TextEditingController controller,
  }) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2.0),
        child: TextField(
          controller: controller,
          maxLines: null,
          decoration: InputDecoration(
            border: PaintlessRoundedBorder(),
            fillColor: Color.fromRGBO(173, 7, 46, 1),
            labelStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            counterStyle: TextStyle(
              color: Colors.white,
            ),
            filled: true,
            labelText: label,
          ),
          style: TextStyle(color: Colors.white, fontSize: 16),
          cursorColor: Colors.white,
          cursorWidth: 2,
          cursorHeight: 20,
        ),
      ),
    );
  }
}
