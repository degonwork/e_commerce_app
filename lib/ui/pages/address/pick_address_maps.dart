import 'package:e_commerce_app_getx/controllers/location_controller.dart';
import 'package:e_commerce_app_getx/routes/route_helper.dart';
import 'package:e_commerce_app_getx/ui/pages/address/widgets/search_location_dialog_page.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/custom_button.dart';
import 'package:e_commerce_app_getx/ui/utils/colors.dart';
import 'package:e_commerce_app_getx/ui/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignUp;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddressMap(
      {Key? key,
      required this.fromSignUp,
      required this.fromAddress,
      this.googleMapController})
      : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;
  late LatLng _changePosition;

  @override
  void initState() {
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(45.51563, -122.677433);

      _cameraPosition = CameraPosition(
          target: _initialPosition, zoom: Dimensions.width10 * 1.7);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress['latitude']),
            double.parse(
                Get.find<LocationController>().getAddress['longitude']));
        _changePosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress['latitude']),
            double.parse(
                Get.find<LocationController>().getAddress['longitude']));
        _cameraPosition = CameraPosition(
            target: _initialPosition, zoom: Dimensions.width10 * 1.7);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SizedBox(
                width: double.maxFinite,
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _initialPosition,
                        zoom: Dimensions.width10 * 1.7,
                      ),
                      zoomControlsEnabled: false,
                      onCameraMove: (CameraPosition cameraPosition) {
                        _cameraPosition = cameraPosition;
                      },
                      onCameraIdle: () {
                        Get.find<LocationController>()
                            .updatePosition(_cameraPosition, false);
                      },
                      onMapCreated: (GoogleMapController mapController) {
                        _mapController = mapController;
                      },
                    ),
                    Center(
                      child: !locationController.loading
                          ? Image.asset(
                              'assets/image/pick_marker.png',
                              height: Dimensions.height10 * 5,
                              width: Dimensions.width10 * 5,
                            )
                          : CircularProgressIndicator(),
                    ),
                    Positioned(
                      top: Dimensions.height45,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: InkWell(
                        onTap: () => Get.dialog(
                          SearchLocationDialogue(
                            mapController: _mapController,
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width10),
                          height: Dimensions.height10 * 5,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20 / 2),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.location_on,
                                  size: Dimensions.width10 * 2.5,
                                  color: AppColors.yellowColor),
                              Expanded(
                                child: Text(
                                  '${locationController.pickPlacemark.name ?? ''}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Dimensions.font16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: Dimensions.width10),
                              Icon(Icons.search,
                                  size: Dimensions.width10 * 2.5,
                                  color: AppColors.yellowColor),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: Dimensions.height10 * 8,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: locationController.isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : CustomButton(
                              buttonText: locationController.inZone
                                  ? widget.fromAddress
                                      ? "Pick Address"
                                      : "Pick Location"
                                  : "Service is not available in your area",
                              onPressed: (locationController.buttonDisable ||
                                      locationController.loading)
                                  ? null
                                  : () {
                                      if (locationController
                                                  .pickPosition.latitude !=
                                              0 &&
                                          locationController
                                                  .pickPlacemark.name !=
                                              null) {
                                        if (widget.fromAddress) {
                                          if (widget.googleMapController !=
                                              null) {
                                            widget.googleMapController!
                                                .moveCamera(
                                              CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                    target: LatLng(
                                                      locationController
                                                          .pickPosition
                                                          .latitude,
                                                      locationController
                                                          .pickPosition
                                                          .longitude,
                                                    ),
                                                    zoom: Dimensions.width10 *
                                                        1.7),
                                              ),
                                            );
                                            locationController
                                                .setAddAddressData();
                                          }
                                          Get.back();
                                        }
                                      }
                                    },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
