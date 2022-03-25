import 'dart:convert';

JobList jobListFromJson(String str) => JobList.fromJson(json.decode(str));

String jobListToJson(JobList data) => json.encode(data.toJson());

class JobList {
  JobList({
    this.strOrderBy,
    this.recPerPage,
    this.pageIndex,
    this.keyword,
    this.location,
    this.jobRole,
    this.jobType,
    this.datePosted,
    this.experienceLevel,
    this.jobJobcategoryId,
    this.salaryMin,
    this.salaryMax,
    this.jobUuid,
    this.jobTypeIdIdsList,
    this.employementTypeIdsList,
  });

  String strOrderBy;
  String recPerPage;
  String pageIndex;
  String keyword;
  String location;
  String jobRole;
  String jobType;
  String datePosted;
  String experienceLevel;
  String jobJobcategoryId;
  String salaryMin;
  String salaryMax;
  String jobUuid;
  String jobTypeIdIdsList;
  String employementTypeIdsList;

  factory JobList.fromJson(Map<String, dynamic> json) => JobList(
        strOrderBy: json["strOrderBy"],
    jobTypeIdIdsList: json["jobTypeIdIdsList"],
        recPerPage: json["recPerPage"],
        pageIndex: json["pageIndex"],
        keyword: json["keyword"],
        location: json["location"],
        jobRole: json["jobRole"],
        jobType: json["jobType"],
        datePosted: json["datePosted"],
        experienceLevel: json["experienceLevel"],
         employementTypeIdsList: json["employementTypeIdsList"],
        jobJobcategoryId: json["jobJobcategoryId"],
        salaryMin: json["salaryMin"],
        salaryMax: json["salaryMax"],
        jobUuid: json["jobUuid"],
      );

  Map<String, dynamic> toJson() => {
        "strOrderBy": strOrderBy,
        "recPerPage": recPerPage,
        "pageIndex": pageIndex,
        "keyword": keyword,
        "location": location,
        "jobTypeIdIdsList": jobTypeIdIdsList,
        "jobRole": jobRole,
        "jobType": jobType,
        "employementTypeIdsList": employementTypeIdsList,
        "datePosted": datePosted,
        "experienceLevel": experienceLevel,
        "jobJobcategoryId": jobJobcategoryId,
        "salaryMin": salaryMin,
        "salaryMax": salaryMax,
        "jobUuid": jobUuid,
      };
}



class JobDes{
  String jobUuid;

  JobDes({this.jobUuid});

  Map<String, dynamic> toJson() {
    return {
      "jobUuid": jobUuid,
    };
  }

}

class SavedJob{
  String sort;

  SavedJob({this.sort});

  Map<String, dynamic> toJson() {
    return {
      "sort": sort,
    };
  }

}