import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sport_app_semicolon/Data/Models/get_goals_model.dart';
import 'package:sport_app_semicolon/Data/Models/get_players_model.dart';
import 'package:sport_app_semicolon/Data/Models/get_teams_model.dart';
import 'package:sport_app_semicolon/Data/Repository/get_League_Repo.dart';

int team_id = 585;

class GetPlayersRepo {
  Future<GetPlayersModel?> getPlayers() async {
    try {
      var playersresponse = await http.get(
        Uri.parse(
            "https://apiv2.allsportsapi.com/football/?&met=Players&teamId=585&APIkey=62100878725f17609eea14c194265875c288ab8171d713f854c929bb76206eb2"),
      );

      var decodedResponse = jsonDecode(playersresponse.body);

      if (playersresponse.statusCode == 200) {
        GetPlayersModel myResponse = GetPlayersModel.fromJson(decodedResponse);

        return myResponse;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
