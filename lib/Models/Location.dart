class Cities{
  String cityId;
  String cityName;

  Cities({this.cityId,this.cityName,});

  factory Cities.fromJson(Map<String,dynamic> item){
    return Cities(
        cityId: item["cityId"],
        cityName: item["cityName"]
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['cityId'] = this.cityId;
    data['cityName'] = this.cityName;
    return data;
  }
}