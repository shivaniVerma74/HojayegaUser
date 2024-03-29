class ApiServicves {
  static const String baseUrl =
      "https://developmentalphawizz.com/hojayega/api/";
  static const String imageUrl =
      "https://developmentalphawizz.com/hojayega/uploads/profile_pics/";

  static const String veriftOtp = baseUrl + 'verify_otp';
  static const String register = baseUrl + 'user_register';
  static const String login = baseUrl + 'login';
  static const String getBanners = baseUrl + 'get_banners';
  static const String forgetPassword = baseUrl + 'forgot_pass_driver';
  static const String changePaesword = baseUrl + 'change_password';
  static const String sendOtp = baseUrl + 'send_otp_singup';
  static const String shopsType = baseUrl + 'type_shops';
  static const String getProfile = baseUrl + 'get_profile';
  static const String getShopCategories = baseUrl + 'shop_get_categories_list';
  static const String updateUser = baseUrl + 'update_profile_user';
  static const String getProfiles = baseUrl + 'get_profile';
  static const String pickDropOrder = baseUrl + 'pick_drop_order';
  static const String childCategories = baseUrl + 'child_category';
  static const String getSubCategories = baseUrl + 'show_sub_category';
  static const String getStates = baseUrl + 'get_states';
  static const String getVendors = baseUrl + 'vendor_data';
  static const String privacyPolicy = baseUrl + 'privacy_policy';
  static const String staticpages = baseUrl + 'static_pages';
  static const String getCitys = baseUrl + 'get_cities';
  static const String getCountrys = baseUrl + 'get_countries';
  static const String getSettings = baseUrl + 'general_setting';
  static const String getProductCatwise =
      baseUrl + 'get_all_products_by_vendor';
  static const String addTocart = baseUrl + 'add_to_cart';
  static const String sendOtpforgetpassword = baseUrl + 'forgot_pass_user';
  static const String resetpassword = baseUrl + 'reset_password';
  static const String getOfferBanner = baseUrl + 'ad_offer_banner';
  static const String getAddress = baseUrl + 'get_address';
  static const String addAddress = baseUrl + 'add_address';
  static const String deleteAddress = baseUrl + 'delete_address';
  static const String updateAddress = baseUrl + 'update_address';
  static const String placeOrder = baseUrl + 'place_order';
  static const String getTimeSlot = baseUrl + 'get_time_slot';
  static const String getregions = baseUrl + 'get_regions';
  static const String getOrder = baseUrl + 'get_users_orders';
  static const String cancleOrder = baseUrl + 'cancel_order';
  static const String vendorCharges = baseUrl + 'vendor_charges';
  static const String clickUser = baseUrl + 'click_user';

  //services Api
  static const String getServicesCat = baseUrl + 'get_vendor_servicess';
  static const String serviceDetail = baseUrl + 'get_vendor_servicesss';
  static const String gerServicesofServices = baseUrl + 'type_shops';
  static const String vendor_bank_detail = baseUrl + 'get_vendor_bank_details';
  static const String servicePaymentDone = baseUrl + 'booking_payment';
  static const String addToWishlist = baseUrl + 'likePro';
  static const String removeFromWishlist = baseUrl + 'unlike_product';
  static const String getCalender = baseUrl + 'get_booked_booking_calender';
  static const String notification = baseUrl + 'notifications';
  static const String clearNoti = baseUrl + 'clear_all';
  static const String search = baseUrl + 'search';
  static const String bookingHistory = baseUrl + 'get_bookings';
  static const String bookingAmt = baseUrl + 'get_bookings_details';
}

String? user_id;
String? user_name;
String? user_mobile;
String? user_email;
