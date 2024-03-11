
class JobSearch {
  int? status;
  bool? success;
  String? message;
  Data? data;

  JobSearch({this.status, this.success, this.message, this.data});

  JobSearch.fromJson(Map<String, dynamic> json) {
    if(json["status"] is int) {
      status = json["status"];
    }
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
    _data["status"] = status;
    _data["success"] = success;
    _data["message"] = message;
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  List<Job>? job;

  Data({this.job});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["job"] is List) {
      job = json["job"] == null ? null : (json["job"] as List).map((e) => Job.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(job != null) {
      _data["job"] = job?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Job {
  int? id;
  String? applicantsId;
  int? companyId;
  String? status;
  String? city;
  String? jobTitle;
  String? jobType;
  int? vacancy;
  String? closingDate;
  String? saleryPkg;
  String? jobFilter;
  String? experience;
  String? education;
  String? description;
  String? responsibility;
  String? benefits;
  String? createdAt;
  String? updatedAt;

  Job({this.id, this.applicantsId, this.companyId, this.status, this.city, this.jobTitle, this.jobType, this.vacancy, this.closingDate, this.saleryPkg, this.jobFilter, this.experience, this.education, this.description, this.responsibility, this.benefits, this.createdAt, this.updatedAt});

  Job.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["applicants_id"] is String) {
      applicantsId = json["applicants_id"];
    }
    if(json["company_id"] is int) {
      companyId = json["company_id"];
    }
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["city"] is String) {
      city = json["city"];
    }
    if(json["job_title"] is String) {
      jobTitle = json["job_title"];
    }
    if(json["job_type"] is String) {
      jobType = json["job_type"];
    }
    if(json["vacancy"] is int) {
      vacancy = json["vacancy"];
    }
    if(json["closing_date"] is String) {
      closingDate = json["closing_date"];
    }
    if(json["salery_pkg"] is String) {
      saleryPkg = json["salery_pkg"];
    }
    if(json["job_filter"] is String) {
      jobFilter = json["job_filter"];
    }
    if(json["experience"] is String) {
      experience = json["experience"];
    }
    if(json["education"] is String) {
      education = json["education"];
    }
    if(json["description"] is String) {
      description = json["description"];
    }
    if(json["responsibility"] is String) {
      responsibility = json["responsibility"];
    }
    if(json["benefits"] is String) {
      benefits = json["benefits"];
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["applicants_id"] = applicantsId;
    _data["company_id"] = companyId;
    _data["status"] = status;
    _data["city"] = city;
    _data["job_title"] = jobTitle;
    _data["job_type"] = jobType;
    _data["vacancy"] = vacancy;
    _data["closing_date"] = closingDate;
    _data["salery_pkg"] = saleryPkg;
    _data["job_filter"] = jobFilter;
    _data["experience"] = experience;
    _data["education"] = education;
    _data["description"] = description;
    _data["responsibility"] = responsibility;
    _data["benefits"] = benefits;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}