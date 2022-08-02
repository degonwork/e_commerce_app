class SignUpBody {
  SignUpBody({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
  });

  final int? id;
  final String? email;
  final String? username;
  final String? password;
  final Name? name;
  final Address? address;
  final String? phone;

  factory SignUpBody.fromJson(Map<String, dynamic> json) {
    return SignUpBody(
      id: json["id"],
      email: json["email"],
      username: json["username"],
      password: json["password"],
      name: Name.fromJson(json["name"]),
      address: Address.fromJson(json["address"]),
      phone: json["phone"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "email": this.email,
      "username": this.username,
      "password": this.password,
      "name": this.name!.toJson(),
      "address": this.address!.toJson(),
      "phone": this.phone,
    };
  }
}

class Address {
  Address({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  final Geolocation? geolocation;
  final String? city;
  final String? street;
  final int? number;
  final String? zipcode;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      geolocation: Geolocation.fromJson(json["geolocation"]),
      city: json["city"],
      street: json["street"],
      number: json["number"],
      zipcode: json["zipcode"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "geolocation": this.geolocation!.toJson(),
      "city": this.city,
      "street": this.street,
      "number": this.number,
      "zipcode": this.zipcode,
    };
  }
}

class Geolocation {
  Geolocation({
    required this.lat,
    required this.long,
  });

  final String? lat;
  final String? long;

  factory Geolocation.fromJson(Map<String, dynamic> json) {
    return Geolocation(
      lat: json["lat"],
      long: json["long"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lat": this.lat,
      "long": this.long,
    };
  }
}

class Name {
  Name({
    required this.firstname,
    required this.lastname,
  });

  final String? firstname;
  final String? lastname;

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      firstname: json["firstname"],
      lastname: json["lastname"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "firstname": this.firstname,
      "lastname": this.lastname,
    };
  }
}
