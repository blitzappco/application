import 'package:application/components/step_card_types/step_card.dart';
import 'package:application/maps/geocode.dart';
import 'package:application/maps/predictions.dart';
import 'package:application/maps/routes.dart';
import 'package:application/models/place.dart';
import 'package:application/models/route.dart' as route;
import 'package:application/utils/get_location.dart';
import 'package:application/utils/polyline.dart';
import 'package:application/utils/steps.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    predictions = await fetchPredictions(input);
    notifyListeners();
  }

  setFromCurrentLocation() async {
    // loading = true;
    // notifyListeners();

    final position = await getCurrentLocation();

    final place = await fetchPlaceFromLatLng(
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

    routes =
        await fetchRoutes('place_id:${from.placeID}', 'place_id:${to.placeID}');
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

    routes = await fetchRoutes('place_id:ChIJSXffqfwBskARd6UO_FI4HH8',
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
    polylinesSet = <Polyline>{
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

  initMap() async {
    map = true;
    notifyListeners();
  }
}
