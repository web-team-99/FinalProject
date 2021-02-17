import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          children: [
            Text(
              'text lsdkj sdfsdkfjsa d jsd ls dj sj s;df ;s fd d skjdf sdjsdsk j  jd fjsld jslf jsl f;ld j;',
              style: theme.textTheme.bodyText2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
