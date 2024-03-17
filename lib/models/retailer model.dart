class RetailerModel {
  String retailerNo;
  String name;
  String email;
  String mobileNo;
  String address;
  String password;

  RetailerModel({
    required this.retailerNo,
    required this.name,
    required this.email,
    required this.mobileNo,
    required this.address,
    required this.password,
  });

  // fromMap method
  factory RetailerModel.fromMap(Map<String, dynamic> map) {
    return RetailerModel(
      retailerNo: map['retailerNo'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      mobileNo: map['mobileNo'] ?? '',
      address: map['address'] ?? '',
      password: map['password'] ?? '',
    );
  }

  // toMap method
  Map<String, dynamic> toMap() {
    return {
      'retailerNo': retailerNo,
      'name': name,
      'email': email,
      'mobileNo': mobileNo,
      'address': address,
      'password': password,
    };
  }

  // fromJson method
  factory RetailerModel.fromJson(Map<String, dynamic> json) => RetailerModel(
    retailerNo: json["retailerNo"],
    name: json["name"],
    email: json["email"],
    mobileNo: json["mobileNo"],
    address: json["address"],
    password: json["password"],
  );

  // toJson method
  Map<String, dynamic> toJson() => {
    "retailerNo": retailerNo,
    "name": name,
    "email": email,
    "mobileNo": mobileNo,
    "address": address,
    "password": password,
  };
}

