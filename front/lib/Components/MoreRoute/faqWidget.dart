import 'package:flutter/material.dart';
import 'package:test_url/Components/MoreRoute/CustomExpansionTile.dart';

class FaqWidget extends StatelessWidget {
  final Map<String, Object> item;
  final String question;
  final String answer;

  FaqWidget(this.item, this.question, this.answer);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      // decoration: BoxDecoration(border: Border.all(width: 1)),
      padding: const EdgeInsets.all(2.0),
      child: CustomExpansionTile(
        backgroundColor: Theme.of(context).cardColor,
        childrenPadding: EdgeInsets.all(16),
        title: Text(
          item[question],
        ),
        children: [
          Container(
            width: double.infinity,
            child: SelectableText(
              item[answer],
              style: theme.textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }
}
