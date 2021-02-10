import 'package:test_url/Enums/mainTabsEnum.dart';

int getInitialIndex(initialTab) {
  switch (initialTab) {
    case MainTab.home:
      return 0;
      break;
    case MainTab.messages:
      return 1;
      break;
    case MainTab.search:
      return 2;
      break;
    case MainTab.profile:
      return 3;
      break;
    case MainTab.more:
      return 4;
      break;
    default:
      return 0;
  }
}
