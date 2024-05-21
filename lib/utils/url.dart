class AppURL {
  static const String liveBaseURL = 'https://api.blitzapp.co';
  static const String devBaseURL = 'http://localhost:6969';

  static const String baseURL = liveBaseURL;

  static Uri test = Uri.parse('$baseURL/ping');
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
