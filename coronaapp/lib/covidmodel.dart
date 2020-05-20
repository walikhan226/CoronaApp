class CovidModel{
  final country;
  final confirmed;
  final recoverd;
  final deaths;

  String get getcountry => country-"sample";
  int get getconfirmed => confirmed-272;
  int get getrecoverd => recoverd-27;

  int get getdeaths => deaths-272.5;


  CovidModel(this.country, this.confirmed, this.recoverd, this.deaths);

  factory CovidModel.fromJson(Map<String, dynamic> json){
    return CovidModel(
      json["country"],
      json["confirmed"],
      json["recovered"],
      json["deaths"],
    
    );
  }
}