import 'package:flutter/material.dart';
import 'package:test_url/Components/asyncImageLoader.dart';
import '../../models/ProviderModels/manualModel.dart';
import 'CustomExpansionTile.dart';

class ManualWidget extends StatelessWidget {
  final ManualModel manualModel;

  ManualWidget({@required this.manualModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(border: Border.all(width: 1)),
      padding: const EdgeInsets.all(2.0),
      child: CustomExpansionTile(
        backgroundColor: Theme.of(context).cardColor,
        childrenPadding: EdgeInsets.all(16),
        title: Text(
          manualModel.title,
        ),
        children: [...manualModel.entries.map((e) => _ManualEntry(e)).toList()],
      ),
    );
  }
}

class _ManualEntry extends StatelessWidget {
  final ManualEntry manualEntry;

  _ManualEntry(this.manualEntry);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.white,
                  blurRadius: 5.0,
                  spreadRadius: 0.0,
                  offset: Offset(0.0, 0.0))
            ],
          ),
          child: SelectableText(
            manualEntry.title,
            style: theme.textTheme.headline5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Container(
            width: double.infinity,
            child: SelectableText(
              manualEntry.description,
              style: theme.textTheme.bodyText1,
            ),
          ),
        ),
        if (manualEntry.imageUrl != null)
          AspectRatio(
            aspectRatio: 1.5,
            child: Container(
              // height: _width / 4,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: AsyncImageLoader(manualEntry.imageUrl),
              ),
            ),
          ),
        Divider(),
      ],
    );
  }
}
