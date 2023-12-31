class ApiServicves{

  static const String baseUrl = "https://developmentalphawizz.com/hojayega/api/";
  static const String imageUrl = "https://developmentalphawizz.com/hojayega/uploads/profile_pics/";

  static const String veriftOtp = baseUrl+'verify_otp';
  static const String register = baseUrl+'user_register';
  static const String login = baseUrl+'login';
  static const String getBanners = baseUrl+'get_banners';
  static const String forgetPassword = baseUrl+'forgot_pass_driver';
  static const String changePaesword = baseUrl+'change_password';
  static const String sendOtp = baseUrl+'send_otp_singup';
  static const String shopsType = baseUrl+'type_shops';
  static const String getProfile = baseUrl+'get_profile';
  static const String getShopCategories = baseUrl+'shop_get_categories_list';
  static const String updateUser = baseUrl+'update_profile_user';
  static const String getProfiles = baseUrl+'get_profile';
  static const String childCategories = baseUrl+'child_category';
  static const String getSubCategories = baseUrl+'show_sub_category';
  static const String getStates = baseUrl+'get_states';
  static const String getVendors = baseUrl+'vendor_data';
  static const String privacyPolicy = baseUrl+'privacy_policy';
  static const String staticpages = baseUrl+'static_pages';
  static const String getCitys = baseUrl+'get_cities';
  static const String getCountrys = baseUrl+'get_countries';
  static const String getSettings = baseUrl+'general_setting';
  static const String getProductCatwise = baseUrl+'get_all_products_by_vendor';
}

String? user_id;
String? user_name;
String? user_mobile;
String? user_email;