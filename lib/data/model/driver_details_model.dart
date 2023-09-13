// ignore_for_file: unnecessary_question_mark, prefer_void_to_null, unnecessary_new, prefer_collection_literals, unnecessary_this, non_constant_identifier_names

class Driver {
  Data? data;
  String? message;

  Driver({this.data, this.message});

  Driver.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  dynamic? emailVerifiedAt;
  dynamic? fcm_token;
  dynamic? device_type;
  dynamic? device_token;
  String? createdAt;
  String? updatedAt;
  String? image;
  dynamic? aadhar;
  dynamic? visaStatus;
  dynamic? visaExpiry;
  String? baseSalary;
  String? emiratesNo;
  String? aadharNo;
  String? accountNo;
  dynamic? passport;
  dynamic? emiratesId;
  dynamic? pancard;
  dynamic? cv;
  dynamic? appointment;
  dynamic? mutal;
  String? token;

  Data(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.fcm_token,
      this.device_token,
      this.device_type,
      this.createdAt,
      this.updatedAt,
      this.image,
      this.aadhar,
      this.visaStatus,
      this.visaExpiry,
      this.baseSalary,
      this.emiratesNo,
      this.aadharNo,
      this.accountNo,
      this.passport,
      this.emiratesId,
      this.pancard,
      this.cv,
      this.appointment,
      this.mutal,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    fcm_token = json['fcm_token'];
    device_token = json['device_token'];
    device_type = json['device_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    aadhar = json['aadhar'];
    visaStatus = json['visa_status'];
    visaExpiry = json['visa_expiry'];
    baseSalary = json['base_salary'];
    emiratesNo = json['emirates_no'];
    aadharNo = json['aadhar_no'];
    accountNo = json['account_no'];
    passport = json['passport'];
    emiratesId = json['emirates_id'];
    pancard = json['pancard'];
    cv = json['cv'];
    appointment = json['appointment'];
    mutal = json['mutal'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['fcm_token'] = this.fcm_token;
    data['device_token'] = this.device_token;
    data['device_type'] = this.device_type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['aadhar'] = this.aadhar;
    data['visa_status'] = this.visaStatus;
    data['visa_expiry'] = this.visaExpiry;
    data['base_salary'] = this.baseSalary;
    data['emirates_no'] = this.emiratesNo;
    data['aadhar_no'] = this.aadharNo;
    data['account_no'] = this.accountNo;
    data['passport'] = this.passport;
    data['emirates_id'] = this.emiratesId;
    data['pancard'] = this.pancard;
    data['cv'] = this.cv;
    data['appointment'] = this.appointment;
    data['mutal'] = this.mutal;
    data['token'] = this.token;
    return data;
  }
}
