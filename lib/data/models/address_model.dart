class AddressMaps {
  late int? _id;
  late String _addressType;
  late String? _contactPersonName;
  late String? _contactPersonNumber;
  late String _address;
  late String _latitude;
  late String _longtitude;
  AddressMaps({
    id,
    required addressType,
    contactPersonName,
    contactPersonNumber,
    address,
    latitude,
    longtitude,
  }) {
    _id = id;
    _addressType = addressType;
    _contactPersonName = contactPersonName;
    _contactPersonNumber = contactPersonNumber;
    _address = address;
    _latitude = latitude;
    _longtitude = longtitude;
  }
  String get address => _address;
  String get addressType => _addressType;
  String? get contactPersonName => _contactPersonName;
  String? get contactPersonNumber => _contactPersonNumber;
  String get latitude => _latitude;
  String get longtitude => _longtitude;

  factory AddressMaps.fromJson(Map<String, dynamic> json) {
    return AddressMaps(
      id: json["id"],
      addressType: json["addressType"],
      contactPersonName: json["contactPersonName"],
      contactPersonNumber: json["contactPersonNumber"],
      address: json["address"],
      latitude: json["latitude"],
      longtitude: json["longtitude"],
    );
  }
}
