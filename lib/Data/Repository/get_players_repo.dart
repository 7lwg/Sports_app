import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sport_app_semicolon/Data/Models/get_goals_model.dart';
import 'package:sport_app_semicolon/Data/Models/get_players_model.dart';
import 'package:sport_app_semicolon/Data/Models/get_teams_model.dart';
import 'package:sport_app_semicolon/Data/Repository/get_League_Repo.dart';

String player_name = "";
var team_id;
var temp;

class GetPlayersRepo {
  Future<GetPlayersModel?> getPlayers() async {
    try {
      temp = team_id;
      var playersresponse = await http.get(
        Uri.parse(
            "https://apiv2.allsportsapi.com/football/?&met=Players&teamId=${team_id ?? 0}&playerName=${player_name}&APIkey=ba8cce3a55c7eda219fca0330f1ac53671a427aea4542ae118bd628d6b494a67"),
        // Uri.parse(
        //     "https://apiv2.allsportsapi.com/football/?&met=Players&teamId=80&playerName=${player_name}&APIkey=ba8cce3a55c7eda219fca0330f1ac53671a427aea4542ae118bd628d6b494a67"),
      );

// "https://apiv2.allsportsapi.com/football/?&met=Players&teamId=80&playerName=&APIkey=ba8cce3a55c7eda219fca0330f1ac53671a427aea4542ae118bd628d6b494a67"
// "https://apiv2.allsportsapi.com/football/?&met=Players&teamId=80&playerName=&APIkey=ba8cce3a55c7eda219fca0330f1ac53671a427aea4542ae118bd628d6b494a67"
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
