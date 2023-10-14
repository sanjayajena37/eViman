class ApiFactory {
  // static String BASEURL="http://4.188.234.4:5002";
  static String BASEURL="https://backend.eviman.co.in/api/";

  // static String BASEURL2="http://4.188.234.4:3000";
  static String BASEURL2="http://192.168.0.162:3000";

  static String LOGIN =BASEURL+ "riders/v1/login";
  static String VERIFY_OTP =BASEURL+ "riders/v1/verify";
  static String CREATE_PROFILE =BASEURL+ "riders/v1/create-profile";
  static String UPDATE_PROFILE =BASEURL+ "riders/v1/update-profile/";
  static String GATE_PROFILE =BASEURL+ "riders/v1/profile/";
}