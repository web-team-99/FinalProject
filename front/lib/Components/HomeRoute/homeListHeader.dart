import 'package:flutter/material.dart';
import 'package:test_url/Setting/strings.dart';
import 'package:test_url/Styles/icons.dart';

class HomeListHeader extends StatelessWidget {
  final String title;
  final Function buttonFunction;

  HomeListHeader(this.title, this.buttonFunction);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.textTheme.headline5,
            ),
            RaisedButton(
              child: Center(
                child: Row(
                  children: [
                    Text(
                      moreProjectsAndServices,
                      style: theme.textTheme.bodyText1,
                    ),
                    Container(
                        margin: EdgeInsets.all(5),
                        child: Icon(viewMoreProjectsAndServicesIcon)),
                  ],
                ),
              ),
              onPressed: buttonFunction,
            ),
          ],
        ),
        Divider(
          height: 10,
          thickness: 3,
        ),
      ],
    );
  }
}
