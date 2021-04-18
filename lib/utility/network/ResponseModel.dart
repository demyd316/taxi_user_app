class ResponseModel {
  int statusCode;
  bool status;
  String message;
  Data data;
  String jwt;
  int infoId;

  ResponseModel(
      {this.statusCode,
      this.status,
      this.message,
      this.data,
      this.jwt,
      this.infoId});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    jwt = json['jwt'];
    infoId = json['infoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['jwt'] = this.jwt;
    data['infoId'] = this.infoId;
    return data;
  }
}

class Data {
  String ids = '';
  int id = 0;
  int userID;
  int userIDs = 0;
  int supplierId = 0;
  String role = '';
  int taxiId = 0;
  String lan = '';
  double hourly = 0.0;
  double price = 0.0;
  double peakPrice = 0.0;
  double basePrice = 0.0;
  String status = '';
  String isApproved = '';
  String type = '';
  String phoneNumber = '';
  String email = '';
  String onesingleValue = '';
  String name = '';
  Data(
      {this.ids,
      this.id,
      this.userID,
      this.userIDs,
      this.supplierId,
      this.role,
      this.taxiId,
      this.lan,
      this.hourly,
      this.price,
      this.peakPrice,
      this.basePrice,
      this.status,
      this.isApproved,
      this.type,
      this.phoneNumber,
      this.email,
      this.onesingleValue,
      this.name});
  Data.fromJson(Map<String, dynamic> json) {
    ids = json["ids"];
    id = json["id"];
    userID = json["userID"];
    userIDs = json["userIDs"];
    supplierId = json["supplierId"];
    role = json["role"];
    taxiId = json["taxiId"];
    lan = json["lan"];
    hourly = json["hourly"];
    price = json["price"];
    peakPrice = json["peakPrice"];
    basePrice = json["basePrice"];
    status = json["status"];
    isApproved = json["isApproved"];
    type = json["type"];
    phoneNumber = json["phoneNumber"];
    email = json["email"];
    onesingleValue = json["oneSingleValue"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["ids"] = this.ids;
    data["id"] = this.id;
    data["userID"] = this.userID;
    data["userIDs"] = this.userIDs;
    data["supplierId"] = this.supplierId;
    data["role"] = this.role;
    data["taxiId"] = this.taxiId;
    data["lan"] = this.lan;
    data["hourly"] = this.hourly;
    data["price"] = this.price;
    data["peakPrice"] = this.peakPrice;
    data["basePrice"] = this.basePrice;
    data["status"] = this.status;
    data["isApproved"] = this.isApproved;
    data["type"] = this.type;
    data["phoneNumber"] = this.phoneNumber;
    data["email"] = this.email;
    data["onesingleValue"] = this.onesingleValue;
    data["name"] = this.name;
    return data;
  }
}

class ResponseModel1 {
  int statusCode;
  bool status;
  String message;
  String data;
  String jwt;
  int infoId;

  ResponseModel1(
      {this.statusCode,
      this.status,
      this.message,
      this.data,
      this.jwt,
      this.infoId});

  ResponseModel1.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'];
    jwt = json['jwt'];
    infoId = json['infoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    data['jwt'] = this.jwt;
    data['infoId'] = this.infoId;
    return data;
  }
}


