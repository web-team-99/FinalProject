import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_url/Components/HomeRoute/ProjectAndServiceSuggest.dart';
import 'package:test_url/Components/ProfileRoute/loginHeader.dart';
import 'package:test_url/Cubits/ProjectCreationBloc.dart';
import 'package:test_url/Pages/CustomDialog.dart';

import 'package:test_url/Setting/numbers.dart';
import 'package:test_url/Setting/platform.dart';
import 'package:test_url/Setting/strings.dart';

class ProjectServiceRoute extends StatefulWidget {
  @override
  _ProjectServiceRouteState createState() => _ProjectServiceRouteState();
}

class _ProjectServiceRouteState extends State<ProjectServiceRoute> {
  final _scrollController = ScrollController();

  TextEditingController titleController = new TextEditingController();
  TextEditingController briefDescriptionController =
      new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    bool _mobileView = _width < mobileViewMaxWidth ? true : false;
    ThemeData theme = Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProjectCreationBloc>(create: (context) => ProjectCreationBloc(ProjectCreationInitialState()),)
      ],
          child: Scaffold(
        appBar: isOnIos
            ? CupertinoNavigationBar(
                middle: Text(
                  'Your Projects and Services',
                  style: theme.textTheme.headline5,
                ),
              )
            : AppBar(
                title: Text('Your Projects and Services'),
                centerTitle: true,
                textTheme: theme.textTheme,
              ),
        backgroundColor: theme.backgroundColor,
        body: Scrollbar(
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
                    LoginHeader('create a project / service'),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: briefDescriptionController,
                        decoration: InputDecoration(
                          labelText: 'Brief description',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: descriptionController,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    RaisedButton(
                      child: Text(
                        'create',
                        style: theme.textTheme.bodyText1,
                      ),
                      onPressed: () => {
                        //TODO
                      },
                    ),
                    LoginHeader('your projects'),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 175,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) =>
                            ProjectAndServiceSuggest(
                          'title',
                          'descripti0n',
                          30,
                          21,
                        ),
                      ),
                    ),
                  ],
              )
              ),
            ),
          ),
        ),
      
    );
  }
}
