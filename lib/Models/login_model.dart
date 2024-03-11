
class LoginModel {
  bool? success;
  String? message;
  Data? data;

  LoginModel({this.success, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    if(json["success"] is bool) {
      success = json["success"];
    }
    if(json["message"] is String) {
      message = json["message"];
    }
    if(json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    _data["message"] = message;
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? role;
  String? status;
  dynamic image;
  dynamic location;
  dynamic portfolioSite;
  dynamic coverLetter;
  dynamic resume;
  dynamic companyDetail;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? token;

  Data({this.id, this.name, this.email, this.role, this.status, this.image, this.location, this.portfolioSite, this.coverLetter, this.resume, this.companyDetail, this.emailVerifiedAt, this.createdAt, this.updatedAt, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["role"] is String) {
      role = json["role"];
    }
    if(json["status"] is String) {
      status = json["status"];
    }
    image = json["image"];
    location = json["location"];
    portfolioSite = json["portfolio_site"];
    coverLetter = json["cover_letter"];
    resume = json["resume"];
    companyDetail = json["company_detail"];
    emailVerifiedAt = json["email_verified_at"];
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    if(json["token"] is String) {
      token = json["token"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["email"] = email;
    _data["role"] = role;
    _data["status"] = status;
    _data["image"] = image;
    _data["location"] = location;
    _data["portfolio_site"] = portfolioSite;
    _data["cover_letter"] = coverLetter;
    _data["resume"] = resume;
    _data["company_detail"] = companyDetail;
    _data["email_verified_at"] = emailVerifiedAt;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["token"] = token;
    return _data;
  }
}