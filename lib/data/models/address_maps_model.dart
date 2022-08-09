class AddressMaps {
  late int? _id;
  late String? _addressType;
  late String? _contactPersonName;
  late String? _contactPersonNumber;
  late String? _address;
  late String? _latitude;
  late String? _longitude;
  AddressMaps({
    id,
    required addressType,
    contactPersonName,
    contactPersonNumber,
    address,
    latitude,
    longitude,
  }) {
    _id = id;
    _addressType = addressType;
    _contactPersonName = contactPersonName;
    _contactPersonNumber = contactPersonNumber;
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
  }
  String? get address => _address;
  String? get addressType => _addressType;
  String? get contactPersonName => _contactPersonName;
  String? get contactPersonNumber => _contactPersonNumber;
  String? get latitude => _latitude;
  String? get longitude => _longitude;

  factory AddressMaps.fromJson(Map<String, dynamic> json) {
    return AddressMaps(
      id: json["id"],
      addressType: json["addressType"],
      contactPersonName: json["contactPersonName"],
      contactPersonNumber: json["contactPersonNumber"],
      address: json["address"],
      latitude: json["latitude"],
      longitude: json["longtitude"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this._id,
      'addressType': this._addressType,
      'contactPersonName': this._contactPersonName,
      'contactPersonNumber': this._contactPersonNumber,
      'address': this._address,
      'latitude': this._latitude,
      'longitude': this._longitude,
    };
  }
}
