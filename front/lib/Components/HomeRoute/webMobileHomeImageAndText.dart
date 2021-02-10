import 'package:flutter/material.dart';
import 'package:test_url/Setting/numbers.dart';

class WebMobileHomeImageAndText extends StatelessWidget {
  final String title;
  final String description;
  final String imageAddress;

  WebMobileHomeImageAndText(this.title, this.description, this.imageAddress);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    bool _mobileView = _width < mobileViewMaxWidth ? true : false;
    ThemeData theme = Theme.of(context);

    return Container(
        padding: EdgeInsets.all(20),
        child: Container(
          width: _width * 2 / 3,
          child: Column(
            children: [
              SelectableText(
                title,
                style: theme.textTheme.headline2,
              ),
              Divider(
                height: 10,
                thickness: 3,
              ),
              SelectableText(
                description,
                style: theme.textTheme.headline5,
              ),
              Divider(
                height: 10,
                thickness: 0,
              ),
              Image.asset(imageAddress),
            ],
          ),
        )
        //   ],
        // ),
        );
  }
}
