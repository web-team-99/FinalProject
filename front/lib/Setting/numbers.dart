double appBarHeight = 80;
double pagesTopMargin = 20;
double pagesBottomMargin = 20;
double mobileViewMaxWidth = 600;

double pagesRightAndLeftMargin(double width, bool mobileView) {
  return mobileView ? 10 : width / 4;
}

double homePageRightAndLeftMargin(double width, bool mobileView) {
  return 10;
}
