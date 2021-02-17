import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_url/Components/asyncImageLoader.dart';
import 'package:test_url/Components/comment.dart';
import 'package:test_url/Components/freelanceRequest.dart';
import 'package:test_url/Setting/numbers.dart';
import 'package:test_url/Setting/platform.dart';
import 'package:test_url/Styles/icons.dart';

class ProjectService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();

    double _width = MediaQuery.of(context).size.width;
    bool _mobileView = _width < mobileViewMaxWidth ? true : false;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: isOnIos
          ? CupertinoNavigationBar(
              middle: Text(
                'Project',
                style: theme.textTheme.headline5,
              ),
            )
          : AppBar(
              title: Text('Project'),
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
            child: Card(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      blogDateIcon,
                                    ),
                                  ),
                                  Text(
                                    '12/26/2020',
                                    style: theme.textTheme.subtitle1,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      blogTimeIcon,
                                    ),
                                  ),
                                  Text(
                                    '13:55',
                                    style: theme.textTheme.subtitle1,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 5),
                                child: SelectableText(
                                  'title title asdflks jsdflksj  kdfsj d ls',
                                  style: theme.textTheme.headline5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: AspectRatio(
                          aspectRatio: 1.5,
                          child: Container(
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: AsyncImageLoader(
                                  'http://www.aviny.com/album/defa-moghadas/shakhes/aviny/wallpaper/KAMEL/69.jpg'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: SelectableText(
                            'ldkfjs ajksdlfj sdj fklsj dsal fdflasdj flskd jfjs dkjf; sjdjfkl asdf as;d fjas;ld s;fj s;djf;dlk jsa; jd;fjf;ds  ',
                            style: theme.textTheme.bodyText2,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20.0),
                          height: 175,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) =>
                                FreelanceRequest(),
                          ),
                        ),
                        Comment(),
                        Comment(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
