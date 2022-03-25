class Ownership {
  String ownershipId;
  String ownershipName;

  Ownership({this.ownershipId, this.ownershipName});

  factory Ownership.fromJson(Map<String, dynamic> json) {
    return Ownership(
        ownershipId: json["ownershipId"],
        ownershipName: json["ownershipName"]
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['ownershipId'] = this.ownershipId;
    data['ownershipName'] = this.ownershipName;
    return data;
  }
}
