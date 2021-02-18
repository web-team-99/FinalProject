String apiServer = 'http://localhost:8080';
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

String aboutUsApiUrl = apiServer + '/aboutus';
String contactUsApiUrl = apiServer + '/contactus';
String faqApiUrl = apiServer + '/api/faq';
String manualApiUrl = apiServer + '/api/manual';
String pricingsApiUrl = apiServer + '/api/pricings';
String rulesApiUrl = apiServer + '/rules';
String blogApiUrl = apiServer + '/api/blog';

//projects Provider for each
String projectsApiUrl = apiServer + '/api/project/all';
String unassignedProjectsUrl = apiServer + '/api/project/unassigned';
String assignedProjectsUrl = apiServer + '/api/project/assigned';

//public AuthApi
String signupUrl = apiServer + '/api/register';
String loginUrl = apiServer + '/api/login';

//user  UserDataApi
String usersAllProjects = apiServer + '/api/project/user/all?userid=';
String usersUnassignedProjectsUrl =
    apiServer + '/api/project/user/unassigned?userid=';
String usersAssignedProjectsUrl =
    apiServer + '/api/project/user/assigned?userid=';
String usersAcceptedProjectsUrl =
    apiServer + '/api/project/user/accepted?userid=';
String userDoneProjectsUrl = apiServer + '/api/project/user/done?userid=';
String userOffersUrl = apiServer + '/api/project/offer/user';
String updateProfileUrl = apiServer + '/api/user';

//search user by id
String searchUserUrl = apiServer + '/api/user/byid?userid=';

//project
String createNewProjectUrl = '/api/project/new';
String createOfferUrl = '/api/project/offer';
String assignOfferUrl = '/api/project/assign?offerid=';
String projectOffersUrl = apiServer + '/api/offer/project?projectid=';
String createCommentUrl = apiServer + '/api/comment';
String getCommentsUrl = apiServer + '/api/comment?projectid=';
String deleteCommentUrl = apiServer + '/api/comment?commentid=';
String getProjectUrl = apiServer + '/api/project?projectid=';

String fOffers = apiServer + '/api/project/offer/f'; //???
String user = apiServer + '/api/user'; //???
