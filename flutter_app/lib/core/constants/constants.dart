class Urls {
  static const String foodurl =
      "https://g5-flutter-learning-path-be.onrender.com/api/v1/groceries";

  static String foodbyidUrl(String id) => '$foodurl/$id';
  static String allfoodUrl() => foodurl;
}
