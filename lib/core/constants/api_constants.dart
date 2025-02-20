class ApiConstants {
  static const String baseUrl = "http://10.5.54.169:8000/api";
  static const String loginEndpoint = "http://10.5.54.169:8000/api/login/";
  static const String registerEndpoint = "http://10.5.54.169:8000/api/users/";
  static const String expertsEndpoint = "http://10.5.54.169:8000/api/experts/";
  static const String questionsEndpoint =
      "http://10.5.54.169:8000/api/questions/";
  static const String categoriesEndpoint =
      "http://10.5.54.169:8000/api/categories/";
  static const String answersEndpoint = "http://10.5.54.169:8000/api/answers/";

  static const String authTokenKey = 'auth_token';
  // static const Color primaryColor = Colors.blue;
  static const String expertsListTitle = "Live Experts in 150+ categories";
  static const String expertsListSubtitle = "They are here to serve you";
  static const String noExpertsMessage = "No experts available.";
  static const String defaultTitle = "N/A";
  static const String userIdLabel = "User ID";
  static const String titleLabel = "Title";
  static const String categoriesLabel = "Categories";
  static const String addedToFavouritesMessage = "Added to favourites";
  static const String authTokenMissingMessage = "Auth token is missing";
  static const String askButtonLabel = "Ask";
}
