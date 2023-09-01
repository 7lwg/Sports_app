import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sport_app_semicolon/Data/Models/get_players_model.dart';
import 'package:sport_app_semicolon/Data/Repository/get_players_repo.dart';

part 'players_state.dart';

class GetPlayersCubit extends Cubit<GetPlayersState> {
  GetPlayersCubit() : super(GetPlayersInitial());
  GetPlayersRepo playersRepo = GetPlayersRepo();

  getPlayers() async {
    emit(GetPlayersLoading());

    try {
      await playersRepo.getPlayers().then((value) {
        if (value != null) {
          emit(GetPlayersSuccess(playersresponse: value));
        } else {
          emit(GetPlayersError());
        }
      });
    } catch (error) {
      emit(GetPlayersError());
    }
  }
}
