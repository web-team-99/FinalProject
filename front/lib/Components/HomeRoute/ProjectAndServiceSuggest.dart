import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:test_url/Components/asyncImageLoader.dart';
import 'package:test_url/Pages/Project.dart';
import 'package:test_url/Styles/animations.dart';

class ProjectAndServiceSuggest extends StatelessWidget {
  final String title;
  final String description;
  final int price;
  final int id;

  ProjectAndServiceSuggest(this.title, this.description, this.price, this.id);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return InkWell(
      child: Card(
        child: Container(
            width: 240,
            height: 240,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Flexible(
                  flex: 4,
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: Container(
                      width: double.infinity,
                      child: AsyncImageLoader(
                          'http://www.aviny.com/album/defa-moghadas/shakhes/aviny/wallpaper/KAMEL/69.jpg'),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Text(
                      title,
                      style: theme.textTheme.headline5,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Text(
                      description,
                      style: theme.textTheme.bodyText2,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          price.toString() + '\$',
                          style: theme.textTheme.headline5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
      onTap: () {
        pushNewScreenWithRouteSettings(
          context,
          settings: null,
          screen: ProjectService(),
          pageTransitionAnimation: changePageAnimation,
        );
      },
    );
  }
}
