String apiServer = 'http://138.201.6.240:8001';
String mainServer = 'http://138.201.6.240';
String debugServer = 'http://192.168.1.104';

bool isDebugVersion = false;
String currentServer = isDebugVersion ? debugServer : mainServer;

String homeRouteString = '/home';
String messagesRouteString = '/messages';
String searchRouteString = '/search';
String profileRouteString = '/profile';
String moreRouteString = '/more';
String aboutUsRouteString = '/about-us';
String contactUsRouteString = '/contact-us';
String faqRouteString = '/faq';
String manualRouteString = '/manual';
String pricingRouteString = '/pricing';
String rulesRouteString = '/rules';
String blogRouteString = '/blog';
String softwareTeamRouteString = '/software-team';

String aboutUsUrl = currentServer + aboutUsRouteString;
String contactUsUrl = currentServer + contactUsRouteString;
String faqUrl = currentServer + faqRouteString;
String manualUrl = currentServer + manualRouteString;
String pricingsUrl = currentServer + pricingRouteString;
String rulesUrl = currentServer + rulesRouteString;
String blogUrl = currentServer + blogRouteString;
String softwareTeamUrl = currentServer + softwareTeamRouteString;

String aboutUsApiUrl = apiServer + '/api/about-us';
String contactUsApiUrl = apiServer + '/api/contact-us';
String faqApiUrl = apiServer + '/api/faq';
String manualApiUrl = apiServer + '/api/manual';
String pricingsApiUrl = apiServer + '/api/pricings';
String rulesApiUrl = apiServer + '/api/rules';
String blogApiUrl = apiServer + '/api/blog';
