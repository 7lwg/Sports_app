import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sport_app_semicolon/Data/Models/get_goals_model.dart';
import 'package:sport_app_semicolon/Data/Models/get_teams_model.dart';
import 'package:sport_app_semicolon/Data/Repository/get_League_Repo.dart';
import 'package:sport_app_semicolon/Data/Repository/get_players_repo.dart';

var league_id;
var temp2;
String team_name = "";

class GetTeamsRepo {
  Future<GetTeamsModel?> getTeams() async {
    temp2 = league_id;
    try {
      var teamsresponse = await http.get(
        Uri.parse(
            "https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=${league_id}&teamName=${team_name}&APIkey=ba8cce3a55c7eda219fca0330f1ac53671a427aea4542ae118bd628d6b494a67"),
      );

      var decodedResponse = jsonDecode(teamsresponse.body);

      if (teamsresponse.statusCode == 200) {
        GetTeamsModel myResponse = GetTeamsModel.fromJson(decodedResponse);

        print("heloooo ${myResponse}");

        return myResponse;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}

class GetGoalsRepo {
  Future<GetGoalsModel?> getGoals() async {
    try {
      var goalsresponse = await http.get(
        Uri.parse(
            "https://apiv2.allsportsapi.com/football/?&met=Topscorers&leagueId=${league_id}&APIkey=ba8cce3a55c7eda219fca0330f1ac53671a427aea4542ae118bd628d6b494a67"),
      );

      var decodedResponse = jsonDecode(goalsresponse.body);

      if (goalsresponse.statusCode == 200) {
        GetGoalsModel myResponse = GetGoalsModel.fromJson(decodedResponse);

        return myResponse;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
