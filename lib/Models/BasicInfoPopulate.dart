

import 'dart:convert';

BasicInfoPopulate basicInfoPopulateFromJson(String str) => BasicInfoPopulate.fromJson(json.decode(str));

String basicInfoPopulateToJson(BasicInfoPopulate data) => json.encode(data.toJson());

class BasicInfoPopulate {
  BasicInfoPopulate({
    this.candidateName,
    this.candidateFirstName,
    this.candidateMiddleName,
    this.candidateLastName,
    this.candidateMobile1,
    this.candidateProfileStrength,
    this.candidateEmail1,
    this.candidateGenderName,
    this.candidateGenderId,
    this.candidateTotalWorkExp,
    this.candidateCurrenctCityName,
    this.preferedJobRoleNames,
    this.candidateExperienceId,
  });

  String candidateName;
  String candidateFirstName;
  String candidateMiddleName;
  String candidateLastName;
  String candidateMobile1;
  String candidateEmail1;
  String candidateGenderName;
  String candidateTotalWorkExp;
  String candidateCurrenctCityName;
  String preferedJobRoleNames;
  int candidateExperienceId;
  String candidateGenderId;
  String candidateProfileStrength;

  factory BasicInfoPopulate.fromJson(Map<String, dynamic> json) => BasicInfoPopulate(
    candidateName: json["candidateName"],
    candidateProfileStrength: json["candidateProfileStrength"],
    candidateGenderId: json["candidateGenderId"],
    candidateExperienceId: json["candidateExperienceId"],
    candidateFirstName: json["candidateFirstName"],
    candidateMiddleName: json["candidateMiddleName"],
    candidateLastName: json["candidateLastName"],
    candidateMobile1: json["candidateMobile1"],
    candidateEmail1: json["candidateEmail1"],
    candidateGenderName: json["candidateGenderName"],
    candidateTotalWorkExp: json["candidateTotalWorkExp"],
    candidateCurrenctCityName: json["candidateCurrenctCityName"],
    preferedJobRoleNames: json["preferedJobRoleNames"],
  );

  Map<String, dynamic> toJson() => {
    "candidateName": candidateName,
    "candidateProfileStrength": candidateProfileStrength,
    "candidateGenderId": candidateGenderId,
    "candidateExperienceId": candidateExperienceId,
    "candidateFirstName": candidateFirstName,
    "candidateMiddleName": candidateMiddleName,
    "candidateLastName": candidateLastName,
    "candidateMobile1": candidateMobile1,
    "candidateEmail1": candidateEmail1,
    "candidateGenderName": candidateGenderName,
    "candidateTotalWorkExp": candidateTotalWorkExp,
    "candidateCurrenctCityName": candidateCurrenctCityName,
    "preferedJobRoleNames": preferedJobRoleNames,
  };
}
