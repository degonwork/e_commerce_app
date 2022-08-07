import 'package:e_commerce_app_getx/controllers/auth_controller.dart';
import 'package:e_commerce_app_getx/controllers/location_controller.dart';
import 'package:e_commerce_app_getx/controllers/user_controller.dart';
import 'package:e_commerce_app_getx/data/models/user_model.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/app_text_field.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/big_text.dart';
import 'package:e_commerce_app_getx/ui/utils/colors.dart';
import 'package:e_commerce_app_getx/ui/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(45.51563, -122.677433),
    zoom: 17,
  );
  LatLng _initialPositon = LatLng(45.51563, -122.677433);
  LatLng _changePositon = LatLng(45.51563, -122.677433);

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().user == null) {
      Get.find<UserController>().getUser();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      _cameraPosition = CameraPosition(
          target: LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longtitude']),
      ));
      _initialPositon = LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longtitude']),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Address page"),
          backgroundColor: AppColors.mainColor,
        ),
        body: GetBuilder<UserController>(
          builder: (userController) {
            if (userController.user != null &&
                _contactPersonName.text.isEmpty) {
              _contactPersonName.text =
                  '${userController.user!.name!.firstname}'
                  ' ${userController.user!.name!.lastname}';
              _contactPersonNumber.text = '${userController.user!.phone}';
              if (Get.find<LocationController>().addressList.isNotEmpty) {
                _addressController.text =
                    Get.find<LocationController>().getUserAddress().address;
              }
            }
            return GetBuilder<LocationController>(
              builder: (locationController) {
                _addressController.text =
                    '${locationController.placemark.name ?? ''}'
                    '${locationController.placemark.locality ?? ''}'
                    '${locationController.placemark.postalCode ?? ''}'
                    '${locationController.placemark.country ?? ''}';
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5, top: 5),
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            width: 2, color: Theme.of(context).primaryColor),
                      ),
                      child: Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: _initialPositon,
                              zoom: 17,
                            ),
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            indoorViewEnabled: true,
                            mapToolbarEnabled: false,
                            onCameraIdle: () {
                              locationController.updatePosition(
                                  _changePositon, _cameraPosition, true);
                              _changePositon = _cameraPosition.target;
                            },
                            onCameraMove: (position) =>
                                _cameraPosition = position,
                            onMapCreated: (GoogleMapController controller) {
                              locationController.setMapController(controller);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimensions.height20),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Dimensions.width20,
                      ),
                      child: BigText(
                        text: "Delivery Address",
                      ),
                    ),
                    SizedBox(height: Dimensions.height10),
                    AppTextField(
                      textEditingController: _addressController,
                      hinText: "your addrress",
                      iconData: Icons.map,
                    ),
                    SizedBox(height: Dimensions.height20),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Dimensions.width20,
                      ),
                      child: BigText(
                        text: "Contact Name",
                      ),
                    ),
                    SizedBox(height: Dimensions.height10),
                    AppTextField(
                      textEditingController: _contactPersonName,
                      hinText: "your name",
                      iconData: Icons.person,
                    ),
                    SizedBox(height: Dimensions.height20),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Dimensions.width20,
                      ),
                      child: BigText(
                        text: "Your Phone Number",
                      ),
                    ),
                    SizedBox(height: Dimensions.height10),
                    AppTextField(
                      textEditingController: _contactPersonNumber,
                      hinText: "your phone",
                      iconData: Icons.phone,
                    ),
                  ],
                );
              },
            );
          },
        ));
  }
}
