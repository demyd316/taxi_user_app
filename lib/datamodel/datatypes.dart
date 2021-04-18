import 'package:flutter_taxi_user/utility/network/ResponseModel.dart';

class Triphistoryinfotype {
  double latitude = 0;
  double longitude = 0;
  double km = 0;
  double baseKm = 0;
  double tax = 0;
  double localKm = 0;
  double percentage = 0;
  double price = 0;
  double totalPrice = 0;
  double totalTravelTimePrice = 0;
  double userTotalPrice = 0;
  double basePrice = 0;
  double travelTime = 0;
  double totalwaitTime = 0;
  double estimateTime = 0;
  double debit = 0;
  double discountPrice = 0;
  String radius = '';
  String source = '';
  String destination = '';
  String olddestination = '';
  String desc = '';
  String type = '';
  String userId = '';
  String driverId = '';
  String createdBy = '';
  String status = '';
  String supplierId = '';
  String startDate = '';
  String endDate = '';
  String payment = '';
  String discount = '';
  String category = '';
  String ids = '';
  String updatedOn = '';

  Triphistoryinfotype(
      {this.latitude,
      this.longitude,
      this.km,
      this.baseKm,
      this.tax,
      this.localKm,
      this.percentage,
      this.price,
      this.totalPrice,
      this.totalTravelTimePrice,
      this.userTotalPrice,
      this.basePrice,
      this.travelTime,
      this.totalwaitTime,
      this.estimateTime,
      this.debit,
      this.discountPrice,
      this.radius,
      this.source,
      this.destination,
      this.olddestination,
      this.desc,
      this.type,
      this.userId,
      this.driverId,
      this.createdBy,
      this.status,
      this.supplierId,
      this.startDate,
      this.endDate,
      this.payment,
      this.discount,
      this.category,
      this.ids,
      this.updatedOn});

  Triphistoryinfotype.fromJson(Map<String, dynamic> json) {
    latitude = json["latitude"];
    longitude = json["longitude"];
    km = json["Km"];
    baseKm = json["baseKm"];
    tax = json["tax"];
    localKm = json["localKm"];
    percentage = json["percentage"];
    price = json["price"];
    totalPrice = json["totalPrice"];
    totalTravelTimePrice = json["totalTravelTimePrice"];
    userTotalPrice = json["userTotalPrice"];
    basePrice = json["basePrice"];
    travelTime = json["travelTime"];
    totalwaitTime = json["totalwaitTime"];
    estimateTime = json["estimateTime"];
    debit = json["debit"];
    discountPrice = json["discountPrice"];
    radius = json["radius"];
    source = json["source"];
    destination = json["destination"];
    olddestination = json["olddestination"];
    desc = json["desc"];
    type = json["type"];
    userId = json["userId"];
    driverId = json["driverId"];
    createdBy = json["createdBy"];
    status = json["status"];
    supplierId = json["supplierId"];
    startDate = json["startDate"];
    endDate = json["endDate"];
    payment = json["payment"];
    discount = json["discount"];
    category = json["category"];
    ids = json["ids"];
    updatedOn = json["updatedOn"];
  }
}

// ignore: camel_case_types
class userinfotype {
  String firstname = "Logan";
  String lastname = "Smith";
  String email = "logan@gmail.com"; //@ do validatio
  String password = "";
  String phonenumber = "47638279422";
  String role = "ROLE_DRIVER"; //ROLE_USER or ROLE_SUPPLIER
  String website = "";
  String cartype = ""; //TAXI4 or TAXI6 or VAN or TRANSPORT
  String category = ""; //TAXI
  String domain = "TAXIDEALS";
  double latitude = 80.067439;
  double longitude = 80.237617;
  String ids = "";
  String userid = "";
  int id = 0;
  int taxiid = 0;
  String lan = "EN";
  double hourly = 0;
  double price = 0;
  double peakPrice = 0;
  double basePrice = 0;
  DateTime birthday = new DateTime(1990, 3, 4);
  String gender = "";
}