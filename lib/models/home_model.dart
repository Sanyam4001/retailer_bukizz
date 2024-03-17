class HomeModel {
  String name;
  String mobile;
  String address;
  String city;
  String pincode;
  String ordernumber;
  String column1;
  String column2;
  String column3;
  String grossamount;
  String cancellationcharges;
  String retailer;
  String status;
  String mapaddress;
  String deliveryBoy;

  HomeModel({
    required this.name,
    required this.mobile,
    required this.address,
    required this.city,
    required this.pincode,
    required this.ordernumber,
    required this.column1,
    required this.column2,
    required this.column3,
    required this.grossamount,
    required this.cancellationcharges,
    required this.retailer,
    required this.status,
    required this.mapaddress,
    required this.deliveryBoy
  });

  //fromMap
  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
        name: map['name'] ?? '',
        mobile: map['mobile'] ?? '',
        address: map['address'] ?? '',
        city: map['city'] ?? '',
        pincode: map['pincode'] ?? '',
        ordernumber: map['ordernumber'] ?? '',
        column1: map['column1'] ?? '',
        column2: map['column2'] ?? '',
        column3: map['column3'] ?? '',
        grossamount: map['grossamount'] ?? '',
        cancellationcharges: map['cancellationcharges'] ?? '',
        retailer: map['retailer'] ?? '',
        status: map['status']??'',
        mapaddress: map['mapaddress'],
        deliveryBoy: map['deliveryBoy']
    );
  }

  //toMap
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mobile': mobile,
      'address': address,
      'city': city,
      'pincode': pincode,
      'ordernumber': ordernumber,
      'column1': column1,
      'column2': column2,
      'column3': column3,
      'grossamount': grossamount,
      'cancellationcharges': cancellationcharges,
      'retailer': retailer,
      'status':status,
      'mapaddress':mapaddress,
      'deliveryBoy':deliveryBoy
    };
  }

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    name: json["name"],
    mobile: json["mobile"],
    address: json["address"],
    city: json["city"],
    pincode: json["pincode"],
    ordernumber: json["ordernumber"],
    column1: json["column1"],
    column2: json["column2"],
    column3: json["column3"],
    grossamount: json["grossamount"],
    cancellationcharges: json["cancellationcharges"],
    retailer: json["retailer"],
    status: json["status"],
    mapaddress: json["mapaddress"],
    deliveryBoy: json["deliveryBoy"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile": mobile,
    "address": address,
    "city": city,
    "pincode": pincode,
    "ordernumber": ordernumber,
    "column1": column1,
    "column2": column2,
    "column3": column3,
    "grossamount": grossamount,
    "cancellationcharges": cancellationcharges,
    "retailer": retailer,
    "status":status,
    "mapaddress":mapaddress,
    "deliveryBoy":deliveryBoy
  };
}
