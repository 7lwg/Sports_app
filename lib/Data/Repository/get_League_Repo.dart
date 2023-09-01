import 'dart:convert';
import 'package:sport_app_semicolon/Data/Models/get_League_Model.dart';
import 'package:http/http.dart' as http;

var country_Id;

class GetLeagueRepo {
  Future<LeagueModel?> getLeague() async {
    String apiKey = "62100878725f17609eea14c194265875c288ab8171d713f854c929bb76206eb2";
    try {
      var response = await http.get(Uri.parse(
          "https://apiv2.allsportsapi.com/football/?met=Leagues&countryId=${country_Id}&APIkey=$apiKey"));

      var decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var myResponse = LeagueModel.fromJson(decodedResponse);

        return myResponse;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
