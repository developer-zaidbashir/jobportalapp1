
class CompanyFetch {
  String titleId;
  String titleDesc;

  CompanyFetch({this.titleId, this.titleDesc});

  CompanyFetch.fromJson(Map<String, dynamic> json) {
    titleId = json['titleId'];
    titleDesc = json['titleDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['titleId'] = this.titleId;
    data['titleDesc'] = this.titleDesc;
    return data;
  }
}
