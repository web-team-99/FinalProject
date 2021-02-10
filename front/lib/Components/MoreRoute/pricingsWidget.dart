import 'package:flutter/material.dart';
import 'package:test_url/Setting/strings.dart';
import 'package:test_url/Styles/icons.dart';
import 'package:test_url/models/ProviderModels/pricingsModel.dart';

class PricingsWidget extends StatelessWidget {
  final PricingModel pricingModel;
  PricingsWidget({@required this.pricingModel});

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
                      pricingsIcon,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: SelectableText(pricingModel.title,
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
                  child: SelectableText(pricingModel.description,
                      style: theme.textTheme.bodyText1),
                ),
                Divider(
                  height: 10,
                  thickness: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: SelectableText(
                        pricingModel.price.toString() + payDollarString,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                    RaisedButton(
                      child: Text(
                        payButtonString,
                        style: theme.textTheme.bodyText1,
                      ),
                      onPressed: () => {
                        //TODO
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
