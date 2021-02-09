import 'package:flutter/material.dart';

class MoreTextElement extends StatelessWidget {
  final Map<String, Object> item;
  final String headerKey;
  final String contentKey;
  final IconData itemIcon;

  MoreTextElement(
    this.item,
    this.headerKey,
    this.contentKey,
    this.itemIcon,
  );

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Card(
          margin: EdgeInsets.symmetric(
            vertical: 1,
            horizontal: 3,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      itemIcon,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: SelectableText(item[headerKey],
                            style: theme.textTheme.headline6),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 10,
                  thickness: 3,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SelectableText(item[contentKey],
                      style: theme.textTheme.bodyText1),
                ),
              ],
            ),
          ),
        ),
        // Divider(
        //   height: 10,
        // )
      ],
    );
  }
}
