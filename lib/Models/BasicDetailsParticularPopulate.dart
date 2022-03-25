// To parse this JSON data, do
//
//     final basicParticularPopulate = basicParticularPopulateFromJson(jsonString);

import 'dart:convert';

BasicParticularPopulate basicParticularPopulateFromJson(String str) => BasicParticularPopulate.fromJson(json.decode(str));

String basicParticularPopulateToJson(BasicParticularPopulate data) => json.encode(data.toJson());

class BasicParticularPopulate {
  BasicParticularPopulate({
    this.candidateName,
    this.candidateFirstName,
    this.candidateMiddleName,
    this.candidateLastName,
    this.candidateTitleId,
    this.candidateMobile1,
    this.candidateEmail1,
    this.candidateGenderId,
    this.candidateGenderName,
    this.candidateExperienceId,
    this.candidateTotalWorkExp,
    this.candidateCurrenctCityName,
    this.candidateJobroleIds,
    this.candidatejobroleName,
  });

  String candidateName;
  String candidateFirstName;
  String candidateMiddleName;
  String candidateLastName;
  String candidateTitleId;
  String candidateMobile1;
  String candidateEmail1;
  String candidateGenderId;
  String candidateGenderName;
  int candidateExperienceId;
  String candidateTotalWorkExp;
  String candidateCurrenctCityName;
  String candidateJobroleIds;
  String candidatejobroleName;

  factory BasicParticularPopulate.fromJson(Map<String, dynamic> json) => BasicParticularPopulate(
    candidateName: json["candidateName"],
    candidateFirstName: json["candidateFirstName"],
    candidateMiddleName: json["candidateMiddleName"],
    candidateLastName: json["candidateLastName"],
    candidateTitleId: json["candidateTitleId"],
    candidateMobile1: json["candidateMobile1"],
    candidateEmail1: json["candidateEmail1"],
    candidateGenderId: json["candidateGenderId"],
    candidateGenderName: json["candidateGenderName"],
    candidateExperienceId: json["candidateExperienceId"],
    candidateTotalWorkExp: json["candidateTotalWorkExp"],
    candidateCurrenctCityName: json["candidateCurrenctCityName"],
    candidateJobroleIds: json["candidateJobroleIds"],
    candidatejobroleName: json["candidatejobroleName"],
  );

  Map<String, dynamic> toJson() => {
    "candidateName": candidateName,
    "candidateFirstName": candidateFirstName,
    "candidateMiddleName": candidateMiddleName,
    "candidateLastName": candidateLastName,
    "candidateTitleId": candidateTitleId,
    "candidateMobile1": candidateMobile1,
    "candidateEmail1": candidateEmail1,
    "candidateGenderId": candidateGenderId,
    "candidateGenderName": candidateGenderName,
    "candidateExperienceId": candidateExperienceId,
    "candidateTotalWorkExp": candidateTotalWorkExp,
    "candidateCurrenctCityName": candidateCurrenctCityName,
    "candidateJobroleIds": candidateJobroleIds,
    "candidatejobroleName": candidatejobroleName,
  };
}
