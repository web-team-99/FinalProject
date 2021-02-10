import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  final String title;

  LoginHeader(this.title);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.headline5,
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
