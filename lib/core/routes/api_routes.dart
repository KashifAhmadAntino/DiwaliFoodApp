class ApiUrl {
  static String liveBaseURL = 'https://antino-food-corner.herokuapp.com/';

  static String getItems = '${liveBaseURL}api/item';
  static String getToken = '${liveBaseURL}api/user/add';
  static String placeOrder = '${liveBaseURL}api/order';
  // static String liveBaseURL = 'https://db79-122-161-92-249.in.ngrok.io';
  static String getOrdersHistory = '${liveBaseURL}api/order';
}
