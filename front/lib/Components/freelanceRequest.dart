import 'package:flutter/material.dart';

class FreelanceRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      // margin: EdgeInsets.all(10),
      // padding: EdgeInsets.all(10),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                '365 days',
                style: theme.textTheme.headline5,
              ),
              Text(
                '6500 \$',
                style: theme.textTheme.headline5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    onPressed: () {
                      //TODO
                    },
                    child: Text(
                      'User: ' + 'MammadJavad',
                      style: theme.textTheme.bodyText2,
                    ),
                  ),
                  RaisedButton(
                      child: Text('Accept'),
                      onPressed: () {
                        //TODO
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
