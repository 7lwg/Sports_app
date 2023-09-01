class GetPlayersModel {
  GetPlayersModel({
    required this.success,
    required this.result,
  });
  late final int success;
  late final List<Result> result;

  GetPlayersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result = List.from(json['result']).map((e) => Result.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['result'] = result.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Result {
  Result({
    required this.playerKey,
    required this.playerName,
    this.playerNumber,
    this.playerCountry,
    required this.playerType,
    this.playerAge,
    this.playerMatchPlayed,
    this.playerGoals,
    this.playerYellowCards,
    this.playerRedCards,
    this.playerMinutes,
    required this.playerInjured,
    this.playerSubstituteOut,
    this.playerSubstitutesOnBench,
    this.playerAssists,
    required this.playerIsCaptain,
    this.playerShotsTotal,
    this.playerGoalsConceded,
    this.playerFoulsCommited,
    this.playerTackles,
    this.playerBlocks,
    this.playerCrossesTotal,
    this.playerInterceptions,
    this.playerClearances,
    this.playerDispossesed,
    this.playerSaves,
    this.playerInsideBoxSaves,
    this.playerDuelsTotal,
    this.playerDuelsWon,
    this.playerDribbleAttempts,
    this.playerDribbleSucc,
    this.playerPenComm,
    this.playerPenWon,
    this.playerPenScored,
    this.playerPenMissed,
    this.playerPasses,
    this.playerPassesAccuracy,
    this.playerKeyPasses,
    this.playerWoordworks,
    this.playerRating,
    required this.teamName,
    required this.teamKey,
    this.playerImage,
  });
  late final int playerKey;
  late final String playerName;
  late final Null playerNumber;
  late final Null playerCountry;
  late final String playerType;
  late final Null playerAge;
  late final Null playerMatchPlayed;
  late final Null playerGoals;
  late final Null playerYellowCards;
  late final Null playerRedCards;
  late final Null playerMinutes;
  late final String playerInjured;
  late final Null playerSubstituteOut;
  late final Null playerSubstitutesOnBench;
  late final Null playerAssists;
  late final String playerIsCaptain;
  late final Null playerShotsTotal;
  late final Null playerGoalsConceded;
  late final Null playerFoulsCommited;
  late final Null playerTackles;
  late final Null playerBlocks;
  late final Null playerCrossesTotal;
  late final Null playerInterceptions;
  late final Null playerClearances;
  late final Null playerDispossesed;
  late final Null playerSaves;
  late final Null playerInsideBoxSaves;
  late final Null playerDuelsTotal;
  late final Null playerDuelsWon;
  late final Null playerDribbleAttempts;
  late final Null playerDribbleSucc;
  late final Null playerPenComm;
  late final Null playerPenWon;
  late final Null playerPenScored;
  late final Null playerPenMissed;
  late final Null playerPasses;
  late final Null playerPassesAccuracy;
  late final Null playerKeyPasses;
  late final Null playerWoordworks;
  late final Null playerRating;
  late final String teamName;
  late final int teamKey;
  late final Null playerImage;

  Result.fromJson(Map<String, dynamic> json) {
    playerKey = json['player_key'];
    playerName = json['player_name'];
    playerNumber = null;
    playerCountry = null;
    playerType = json['player_type'];
    playerAge = null;
    playerMatchPlayed = null;
    playerGoals = null;
    playerYellowCards = null;
    playerRedCards = null;
    playerMinutes = null;
    playerInjured = json['player_injured'];
    playerSubstituteOut = null;
    playerSubstitutesOnBench = null;
    playerAssists = null;
    playerIsCaptain = json['player_is_captain'];
    playerShotsTotal = null;
    playerGoalsConceded = null;
    playerFoulsCommited = null;
    playerTackles = null;
    playerBlocks = null;
    playerCrossesTotal = null;
    playerInterceptions = null;
    playerClearances = null;
    playerDispossesed = null;
    playerSaves = null;
    playerInsideBoxSaves = null;
    playerDuelsTotal = null;
    playerDuelsWon = null;
    playerDribbleAttempts = null;
    playerDribbleSucc = null;
    playerPenComm = null;
    playerPenWon = null;
    playerPenScored = null;
    playerPenMissed = null;
    playerPasses = null;
    playerPassesAccuracy = null;
    playerKeyPasses = null;
    playerWoordworks = null;
    playerRating = null;
    teamName = json['team_name'];
    teamKey = json['team_key'];
    playerImage = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['player_key'] = playerKey;
    _data['player_name'] = playerName;
    _data['player_number'] = playerNumber;
    _data['player_country'] = playerCountry;
    _data['player_type'] = playerType;
    _data['player_age'] = playerAge;
    _data['player_match_played'] = playerMatchPlayed;
    _data['player_goals'] = playerGoals;
    _data['player_yellow_cards'] = playerYellowCards;
    _data['player_red_cards'] = playerRedCards;
    _data['player_minutes'] = playerMinutes;
    _data['player_injured'] = playerInjured;
    _data['player_substitute_out'] = playerSubstituteOut;
    _data['player_substitutes_on_bench'] = playerSubstitutesOnBench;
    _data['player_assists'] = playerAssists;
    _data['player_is_captain'] = playerIsCaptain;
    _data['player_shots_total'] = playerShotsTotal;
    _data['player_goals_conceded'] = playerGoalsConceded;
    _data['player_fouls_commited'] = playerFoulsCommited;
    _data['player_tackles'] = playerTackles;
    _data['player_blocks'] = playerBlocks;
    _data['player_crosses_total'] = playerCrossesTotal;
    _data['player_interceptions'] = playerInterceptions;
    _data['player_clearances'] = playerClearances;
    _data['player_dispossesed'] = playerDispossesed;
    _data['player_saves'] = playerSaves;
    _data['player_inside_box_saves'] = playerInsideBoxSaves;
    _data['player_duels_total'] = playerDuelsTotal;
    _data['player_duels_won'] = playerDuelsWon;
    _data['player_dribble_attempts'] = playerDribbleAttempts;
    _data['player_dribble_succ'] = playerDribbleSucc;
    _data['player_pen_comm'] = playerPenComm;
    _data['player_pen_won'] = playerPenWon;
    _data['player_pen_scored'] = playerPenScored;
    _data['player_pen_missed'] = playerPenMissed;
    _data['player_passes'] = playerPasses;
    _data['player_passes_accuracy'] = playerPassesAccuracy;
    _data['player_key_passes'] = playerKeyPasses;
    _data['player_woordworks'] = playerWoordworks;
    _data['player_rating'] = playerRating;
    _data['team_name'] = teamName;
    _data['team_key'] = teamKey;
    _data['player_image'] = playerImage;
    return _data;
  }
}
