
import 'dart:convert';

class SavedJobs {
  SavedJobs({
    this.savedJobList,
    this.totalCount,
  });

  List<SavedJobList> savedJobList;
  int totalCount;

  factory SavedJobs.fromJson(Map<String, dynamic> json) => SavedJobs(
    savedJobList: List<SavedJobList>.from(json["savedJobList"].map((x) => SavedJobList.fromJson(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "savedJobList": List<dynamic>.from(savedJobList.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class SavedJobList {
  SavedJobList({
    this.jobsavedJobId,
    this.jobsavedUuid,
    this.jobsavedTime,
    this.jobHeadline,
    this.companyName,
    this.jobroleName,
  });

  String jobsavedJobId;
  String jobsavedUuid;
  String jobsavedTime;
  String jobHeadline;
  String companyName;
  String jobroleName;

  factory SavedJobList.fromJson(Map<String, dynamic> json) => SavedJobList(
    jobsavedJobId: json["jobsavedJobId"],
    jobsavedUuid: json["jobsavedUuid"],
    jobsavedTime: json["jobsavedTime"],
    jobHeadline: json["jobHeadline"],
    companyName: json["companyName"],
    jobroleName: json["jobroleName"],
  );

  Map<String, dynamic> toJson() => {
    "jobsavedJobId": jobsavedJobId,
    "jobsavedUuid": jobsavedUuid,
    "jobsavedTime": jobsavedTime,
    "jobHeadline": jobHeadline,
    "companyName": companyName,
    "jobroleName": jobroleName,
  };
}
