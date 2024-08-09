const dev = false;
const devCore = true;
const devMantle = false;
const devMercury = false;

const coreURL = !devCore ? "https://core.blitzapp.ro" : "http://localhost:6900";
const coreVersion = "v3.0.0";

const mantleURL =
    !devMantle ? "https://mantle.blitzapp.ro" : "http://localhost:6901";
const mantleVersion = "v3.0.0";

const mercuryURL =
    !devMercury ? "https://mercury.blitzapp.ro" : "http://localhost:6902";
const mercuryVersion = "v3.0.0";

const Map<String, String> basicHeader = <String, String>{
  'Content-Type': 'application/json',
};

Map<String, String> authHeader(String token) {
  return <String, String>{
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
}
