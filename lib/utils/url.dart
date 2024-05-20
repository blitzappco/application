class AppURL {
  static const String liveBaseURL = 'https://api.blitzapp.co';
  static const String devBaseURL = 'http://localhost:4200';

  static const String livePaymentsURL = 'https://payments.blitzapp.co';
  static const String devPaymentsURL = 'http://localhost:5173';

  static const String baseURL = liveBaseURL;
  static const String paymentsURL = livePaymentsURL;

  static Uri test = Uri.parse('$baseURL/accounts/onboarding/test');
}

const Map<String, String> basicHeader = <String, String>{
  'Content-Type': 'application/json',
};

Map<String, String> authHeader(String token) {
  return <String, String>{
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
}
