import 'package:blitz/components/step_card_types/step_card.dart';
import 'package:blitz/utils/get_location.dart';
import 'package:blitz/utils/polyline.dart';
import 'package:blitz/utils/steps.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// bifrost
import 'package:blitz/bifrost/core/endpoints.dart';
import 'package:blitz/bifrost/core/models/place.dart';
import 'package:blitz/bifrost/core/models/route.dart' as route;

class RouteProvider with ChangeNotifier {
  int routeIndex = 0;

  String page = 'home';
  bool map = false;

  double mapPadding = 0;

  bool loading = false;
  String errorMessage = '';

  List<Place> predictions = [];

  late Place from;
  late Place to;

  List<route.Route> routes = [];

  List<Polyline> polylines = [];

  Set<Polyline> polylinesSet = {
    const Polyline(polylineId: PolylineId("0")),
    const Polyline(polylineId: PolylineId("1")),
    const Polyline(polylineId: PolylineId("2")),
    const Polyline(polylineId: PolylineId("3")),
    const Polyline(polylineId: PolylineId("4")),
    const Polyline(polylineId: PolylineId("5")),
    const Polyline(polylineId: PolylineId("6")),
    const Polyline(polylineId: PolylineId("7")),
    const Polyline(polylineId: PolylineId("8")),
    const Polyline(polylineId: PolylineId("9")),
  };

  List<StepCard> stepCards = [];

  getPredictions(String input) async {
    predictions = await getSearch(input);
    notifyListeners();
  }

  clearPredictions() {
    predictions = [];
    notifyListeners();
  }

  setFromCurrentLocation() async {
    // loading = true;
    // notifyListeners();

    final position = await getCurrentLocation();

    final place = await geocodeFromLatLng(
        position?.latitude ?? 0.0, position?.longitude ?? 0.0);

    await setFrom(place);

    // loading = false;
    // notifyListeners();
  }

  Future<void> setFrom(Place f) async {
    from = f;
    notifyListeners();
  }

  Future<void> setTo(Place t) async {
    to = t;
    notifyListeners();
  }

  getRoutes() async {
    if (from.placeID == '' || to.placeID == '') {
      errorMessage = 'from or to inexistent';
      notifyListeners();
      return;
    }

    await changeLoading(true);

    routes = await getItineraries(
        'place_id:${from.placeID}', 'place_id:${to.placeID}');
    notifyListeners();

    await processRoute();

    await changeLoading(false);
  }

  rawGetRoutes() async {
    to = Place(
      placeID: 'ChIJP_VpOEf_sUARUsGG16TtYu4',
      mainText: "Afi cotroceni",
      types: ['shopping_mall'],
    );

    routes = await getItineraries('place_id:ChIJSXffqfwBskARd6UO_FI4HH8',
        'place_id:ChIJP_VpOEf_sUARUsGG16TtYu4');
    notifyListeners();

    await processRoute();
  }

  processRoute() async {
    stepCards = processSteps(routes[routeIndex].leg.steps, to);
    polylines = processPolylines(routes[routeIndex].leg.steps);

    polylinesSet = Set<Polyline>.of(polylines);

    routeIndex = 0;

    notifyListeners();
  }

  unloadPolylines() async {
    polylines = [];
    polylinesSet = Set<Polyline>.of(polylines);
    notifyListeners();
  }

  changeLoading(bool l) async {
    loading = l;
    notifyListeners();
  }

  changeRouteIndex(int i) async {
    routeIndex = i;
    notifyListeners();

    await processRoute();
  }

  changePage(String np) async {
    page = np;
    if (page == "preview") {
      mapPadding = 300;
    }
    notifyListeners();
  }

  initMap() {
    map = true;
    notifyListeners();
  }

  disposeMap() async {
    map = false;
    notifyListeners();
  }
}
