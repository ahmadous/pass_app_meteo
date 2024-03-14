import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  // creation des variables
  final RxBool _isLoading = true.obs;
  final RxDouble _isLattitude = 0.0.obs;
  final RxDouble _isLongitude = 0.0.obs;
  // instance pour les appels
  RxBool checkLoading() => _isLoading;
  RxDouble checkLatitude() => _isLattitude;
  RxDouble checkLongitude() => _isLongitude;
  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error("La Localisation ne s'est pas faite correctement");
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error(
          "Les permissions pour la localisation sont toujours desactivées");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error(
            "Les permissions pour la localisation sont desactivées");
      }
    }
    // obtenir la position de l'utilisateur
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      // latitudee et longitude
      _isLattitude.value = value.latitude;
      _isLongitude.value = value.longitude;
      _isLoading.value = false;
    });
  }
}
