import 'dart:convert';
import 'package:sport_app_semicolon/Data/Models/get_League_Model.dart';
import 'package:http/http.dart' as http;

class GetLeagueRepo {
  Future<LeagueModel?> getLeague() async {
    try {
      var response = await http.get(Uri.parse(
          "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=7d48b49a91d2c3149e5d0b3e7fe68faa5aa51df9375c5d1cba5710191c9225a1"));
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
