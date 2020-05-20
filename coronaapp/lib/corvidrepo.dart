import 'package:http/http.dart' as http;
import 'dart:convert';
import 'covidmodel.dart';
class CovidRepo{
 

Map<String, String> get headers => {
 "content-type": "application/json",
    "x-rapidapi-host": "covid-19-data.p.rapidapi.com",
    "x-rapidapi-key": "c3aed4cda2msha8d9deae3d5835bp1efe02jsn899c70b10861",

};

Future<CovidModel> getdata(String country)async
{

var url = "https://covid-19-data.p.rapidapi.com/country?name=$country";

    print("fetching $url");

    var response = await http.get(url, headers: headers);


    if (response.statusCode != 200) {
      throw Exception(
          "Request to $url failed with status ${response.statusCode}: ${response.body}");
    }


//print(response.body);
return json.decode(response.body);

}
  
  CovidModel parsedJson(final response){
  
    return CovidModel.fromJson(response);
  }
}