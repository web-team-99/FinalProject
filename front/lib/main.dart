import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:test_url/Enums/mainTabsEnum.dart';
import 'package:test_url/Routes/mainScreen.dart';
import 'package:test_url/Setting/router.dart';
import 'package:test_url/Styles/themes.dart';
import 'Configures/configure_nonweb.dart'
    if (dart.library.html) 'Configures/configure_web.dart';


void main() {
  configureApp();
  FluroMainRouter.defineRoutes();
  
  runApp(MyApp(
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final Connectivity connectivity;

  MyApp({@required this.connectivity});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: defaultTheme, //set main theme
        home: MainScreen(
          initialTab: MainTab.home,
          connectivity: connectivity,
        ),
        initialRoute: '/',
        onGenerateRoute: FluroMainRouter.router.generator,
    );
  }
}

//.................... main features to do until 30 Azar, deadline of phase 1: ..........................
//TODO: softWareTeam
