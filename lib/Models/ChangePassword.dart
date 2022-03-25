import 'dart:convert';

ChangePassword changePasswordFromJson(String str) => ChangePassword.fromJson(json.decode(str));

String changePasswordToJson(ChangePassword data) => json.encode(data.toJson());

class ChangePassword {
  ChangePassword({
    this.requestType,
    this.oldPass,
    this.newPass,
    this.confirmNewPass,
  });

  String requestType;
  String oldPass;
  String newPass;
  String confirmNewPass;

  factory ChangePassword.fromJson(Map<String, dynamic> json) => ChangePassword(
    requestType: json["requestType"],
    oldPass: json["oldPass"],
    newPass: json["newPass"],
    confirmNewPass: json["confirmNewPass"],
  );

  Map<String, dynamic> toJson() => {
    "requestType": requestType,
    "oldPass": oldPass,
    "newPass": newPass,
    "confirmNewPass": confirmNewPass,
  };
}
