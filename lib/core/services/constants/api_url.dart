
class ApiUrls {
  /// [get] provider dates
  static String PROVIDER_DATES = 'dates/';

  /// [GET] all providers, must have [city] & [country] as url parameters
  /// [GET] one provider, must have [id]
  static String GET_PROVIDERS = 'beauty_providers/';

  /// [GET] one provider, must have [username] as url parameter

  static String GET_PROVIDER_WITH_USERNAME = 'beauty_providers/username/';

  // ignore: non_constant_identifier_names
  static final POST_REQ_URL = 'orders';
// ignore: non_constant_identifier_names
  static final POST_CANCEL_URL = 'orders/cancel_by_customer';
  // ignore: non_constant_identifier_names
  static final POST_EVALUATE_URL = 'orders/evaluate';
  // ignore: non_constant_identifier_names
  static final POST_SUBMIT_URL = 'orders/submit_by_customer';
// ignore: non_constant_identifier_names
  static final POST_FINISHED_INCOMPLETE = 'orders/finished_incomplete';
// ignore: non_constant_identifier_names
  static final POST_FINISHED_COMPLETE = 'orders/finished_complete';
  // ignore: non_constant_identifier_names
  static final POST_ONE_DAY_ORDERS = 'orders/getDayOrders';

  static final GET_ALL_ORDERS = 'orders/getall';
  static final GET_SALON_SERVICES = 'salon_services'; 
  static final GET_SALON_ALL_SERVICES = 'all_salon_services';
  static final POST_MY_SERVICES = 'salon_products/add_update';
}

