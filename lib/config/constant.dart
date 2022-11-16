
class Constant {
  // static String baseUrl = "http://siapprint.com/";
  // static String baseUrl = "http://192.168.1.8/siaprint/public/";
  static String baseUrl = "http://192.168.56.1/siaprint2/public/";
  // static String baseUrl = "https://dev.siapprint.com/";
  // static String baseUrl = "http://192.168.128.72/siaprint/public/";

  static String apitoken = 'siaprint98765';

  static String login = '${baseUrl}login-api';
  static String basket = '${baseUrl}apibasket';
  static String company_detail = '${baseUrl}apicompany';
  static String apiprint = '${baseUrl}apiprint';
  static String apijne = '${baseUrl}apidelv-jne';
  static String apideliverylist = '${baseUrl}apidelivery';
  static String apisavetransaction = '${baseUrl}apibasketsave';
  static String apiuploadfile = '${baseUrl}apiuploadsave';
  static String apicompanyfromprovince = '${baseUrl}apicompanyfromprovince';
  static String apideletefilebasket = '${baseUrl}apideletefilebasket';
  static String apilisttransaction = '${baseUrl}apilisttransaction';
  static String apistatuscancel = '${baseUrl}apistatuscancel';
  static String apipayment = '${baseUrl}apipayment';

  static String INK_LASER = 'INK001';
  static String INK_TINTA = 'INK002';

}

enum Ink {
  INK_LASER('INK001'),
  INK_TINTA('INK002');

  const Ink(this.code);
  final String code;

}