import 'package:flutter/material.dart';

class FreelanceRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Card(
      child: Container(
        width: 200,
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
                }),
          ],
        ),
      ),
    );
  }
}
