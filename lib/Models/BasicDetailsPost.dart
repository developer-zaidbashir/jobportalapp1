class BasicDetialModel {
  String requestType;
  String candidateTitleId;
  String candidateMobile1;
  String candidateFirstName;
  String candidateMiddleName;
  String candidateLastName;
  String candidateEmail1;
  int candidateGenderId;
  String candidateName;
  int candidateTotalworkexp;
  List candidatePreferredJobRoleList;
  int candidateCurrentCityId;
  int candidateExperienceId;
  BasicDetialModel({
    this.requestType,
    this.candidateTitleId,
    this.candidateMobile1,
    this.candidateFirstName,
    this.candidateMiddleName,
    this.candidateLastName,
    this.candidateEmail1,
    this.candidateGenderId,
    this.candidateName,
    this.candidateTotalworkexp,
    this.candidatePreferredJobRoleList,
    this.candidateCurrentCityId,
    this.candidateExperienceId,
  });

  factory BasicDetialModel.fromJson(Map<String, dynamic> json) {
    return BasicDetialModel(

      candidateTitleId: json["candidateTitleId"],
      candidateMobile1 : json["candidateMobile1"],
      candidateFirstName: json["candidateFirstName"],
      candidateMiddleName: json["candidateMiddleName"],
      candidateLastName: json["candidateLastName"],
      candidateEmail1 : json["candiadateEmail1"],
      candidateGenderId: json["candidateGenderId"],
      candidateName: json["candidateName"],
      candidateTotalworkexp: json["candidateTotalworkexp"],
      candidatePreferredJobRoleList: json["candidatePreferredJobRoleList"],
      candidateCurrentCityId: json["candidateCurrentCityId"],
      candidateExperienceId: json["candidateExperienceId"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['candidateTitleId'] = candidateTitleId;
    data['requestType'] = requestType;
    data["candidateMobile1"] = candidateMobile1;
    data['candidateFirstName'] = candidateFirstName;
    data['candidateMiddleName'] = candidateMiddleName;
    data['candidateLastName'] = candidateLastName;
    data["candiadateEmail1"] = candidateEmail1;
    data['candidateGenderId'] = candidateGenderId;
    data['candidateName'] = candidateName;
    data["candidateTotalworkexp"] = candidateTotalworkexp;
    data['candidatePreferredJobRoleList'] = candidatePreferredJobRoleList;
    data['candidateCurrentCityId'] = candidateCurrentCityId;
    data['candidateExperienceId'] = candidateExperienceId;
    return data;
  }
}

