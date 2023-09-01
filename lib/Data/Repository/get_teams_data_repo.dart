import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sport_app_semicolon/Data/Models/get_goals_model.dart';
import 'package:sport_app_semicolon/Data/Models/get_teams_model.dart';
import 'package:sport_app_semicolon/Data/Repository/get_League_Repo.dart';

var league_id;
String apiKey =
    "62100878725f17609eea14c194265875c288ab8171d713f854c929bb76206eb2";

class GetTeamsRepo {
  Future<GetTeamsModel?> getTeams() async {
    try {
      var teamsresponse = await http.get(
        Uri.parse(
            "https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=${league_id}&APIkey=$apiKey"),
      );

      var decodedResponse = jsonDecode(teamsresponse.body);

      if (teamsresponse.statusCode == 200) {
        GetTeamsModel myResponse = GetTeamsModel.fromJson(decodedResponse);

        print("heloooo ${myResponse}");

        return myResponse;
      } else {
        print("faaaalse");

        return null;
      }
    } catch (error) {
      print("faaaalse ${error}");

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
