import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:test_url/Components/ProfileRoute/loginHeader.dart';
import 'package:test_url/Cubits/AuthBloc.dart';
import 'package:test_url/Cubits/InternetStateCubit.dart';
import 'package:test_url/Pages/CustomDialog.dart';
import 'package:test_url/Pages/Profile/editProfile.dart';

import 'package:test_url/Setting/numbers.dart';
import 'package:test_url/Setting/platform.dart';
import 'package:test_url/Setting/strings.dart';
import 'package:test_url/models/user.dart';

import '../Styles/animations.dart';

class ProfileRoute extends StatefulWidget {
  @override
  _ProfileRouteState createState() => _ProfileRouteState();
}

class _ProfileRouteState extends State<ProfileRoute> {
  TextEditingController signinEmailController = new TextEditingController();
  TextEditingController signinPasswordController = new TextEditingController();
  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupRepeatPasswordController =
      new TextEditingController();

  final _scrollController = ScrollController();

  double _width;
  bool _mobileView;
  AuthBloc authBloc;

  @override
  void dispose() {
    authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _mobileView = _width < mobileViewMaxWidth ? true : false;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: isOnIos
          ? CupertinoNavigationBar(
              middle: Text(
                profilePageTitle,
                style: theme.textTheme.headline5,
              ),
            )
          : AppBar(
              title: Text(profilePageTitle),
              centerTitle: true,
              textTheme: theme.textTheme,
            ),
      backgroundColor: theme.backgroundColor,
      body: createBody(context, theme),
    );
  }

  Widget createBody(BuildContext context, ThemeData theme) {
    authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocBuilder<InternetCubit, InternetState>(builder: (context, state) {
      if (state is InternetDisconnected) {
        return Center(
          child: CustomDialog(
            title: "Disconnected",
            description:
                "You are disconnected from the server.\nPlease check your connection status.",
          ),
        );
      }
      return signupNLoginContent(context, theme);
      // return BlocBuilder(
      //   builder: (context, state) {
      //     switch(state){

      //     }
      //   },
      // );
    });
  }

  Widget signupNLoginContent(BuildContext context, ThemeData theme) {
    return Scrollbar(
      controller: _scrollController,
      isAlwaysShown: true,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(
            bottom: pagesBottomMargin,
            left: pagesRightAndLeftMargin(_width, _mobileView),
            right: pagesRightAndLeftMargin(_width, _mobileView),
          ),
          child: Column(
            children: [
              LoginHeader('sign in'),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: signinEmailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  obscureText: true,
                  controller: signinPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              RaisedButton(
                child: Text(
                  'sign in',
                  style: theme.textTheme.bodyText1,
                ),
                onPressed: () => {
                  // pushNewScreenWithRouteSettings(
                  //   context,
                  //   settings: null,
                  //   screen: EditProfile(),
                  //   pageTransitionAnimation: changePageAnimation,
                  // )
                  authBloc.add(Signin(new User()))
                },
              ),
              LoginHeader('sign up'),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: signupEmailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  obscureText: true,
                  controller: signupPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  obscureText: true,
                  controller: signupRepeatPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Repeat Password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              RaisedButton(
                child: Text(
                  'sign up',
                  style: theme.textTheme.bodyText1,
                ),
                onPressed: () => {
                  // pushNewScreenWithRouteSettings(
                  //   context,
                  //   settings: null,
                  //   screen: EditProfile(),
                  //   pageTransitionAnimation: changePageAnimation,
                  // )
                  authBloc.add(SignUp(new User(name: 'mahfjlshf@gmail.com', password: '12345678')))
                },
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  print(state.currentEvent);
                  return Text(state.toString());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
