
import 'dart:convert';

CompanyList CompanyListFromJson(String str) => CompanyList.fromJson(json.decode(str));

String CompanyListToJson(CompanyList data) => json.encode(data.toJson());

class CompanyList {
  CompanyList({
    this.strOrderBy,
    this.recPerPage,
    this.pageIndex,
    this.keyword,
    this.location,
    this.companyOwnershipId,
    this.companyTypeId,
    this.companySize,
    this.establishedYear,
    this.companyId,
    this.minYear,
    this.maxYear,
    this.sort,
    this.companyUuid,

  });

  String strOrderBy;
  String recPerPage;
  String pageIndex;
  String keyword;
  String location;
  String companyOwnershipId;
  String companyTypeId;
  String companySize;
  String establishedYear;
  String companyId;
  String minYear;
  String maxYear;
  String sort;
  String companyUuid;


  factory CompanyList.fromJson(Map<String, dynamic> json) => CompanyList(
    strOrderBy: json["strOrderBy"],
    recPerPage: json["recPerPage"],
    pageIndex: json["pageIndex"],
    keyword: json["keyword"],
    location: json["location"],
    companyOwnershipId: json["companyOwnershipId"],
    companyTypeId: json["companyTypeId"],
    companySize: json["companySize"],
    establishedYear: json["establishedYear"],
    companyId: json["companyId"],
    minYear: json["minYear"],
    maxYear: json["maxYear"],
    sort: json["sort"],
    companyUuid: json["companyUuid"],

  );

  Map<String, dynamic> toJson() => {
    "strOrderBy": strOrderBy,
    "recPerPage": recPerPage,
    "pageIndex": pageIndex,
    "keyword": keyword,
    "location": location,
    "companyOwnershipId": companyOwnershipId,
    "companyTypeId": companyTypeId,
    "companySize": companySize,
    "establishedYear": establishedYear,
    "companyId": companyId,
    "minYear": minYear,
    "maxYear": maxYear,
    "sort": sort,
    "companyUuid": companyUuid,

  };


}
// class CompDes{
//   String companyUuid;
//
//   CompDes({this.companyUuid});
//
//   Map<String, dynamic> toJson() {
//     return {
//       "companyUuid": companyUuid,
//     };
//   }
//
// }