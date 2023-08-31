import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sport_app_semicolon/Data/Models/get_countries_model.dart';

class GetCountriesRepo {
  
  Future<GetCountriesModel?> getCountries() async {
    
    try {
      String apiKey1 = '62100878725f17609eea14c194265875c288ab8171d713f854c929bb76206eb2';
      var response = await http.get(Uri.parse(
          'https://apiv2.allsportsapi.com/football/?met=Countries&APIkey=$apiKey1'));
      var decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        GetCountriesModel myCountrie = GetCountriesModel.fromJson(decodedResponse);
        return myCountrie;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
