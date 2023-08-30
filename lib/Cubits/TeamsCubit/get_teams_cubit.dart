import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sport_app_semicolon/Data/Models/get_teams_model.dart';
import 'package:sport_app_semicolon/Data/Repository/get_teams_data_repo.dart';

part 'get_teams_state.dart';

class GetTeamsCubit extends Cubit<GetTeamsState> {
  GetTeamsCubit() : super(GetTeamsInitial());
  GetTeamsRepo teamsRepo = GetTeamsRepo();

  getTeams() async {
    emit(GetTeamsLoading());

    try {
      await teamsRepo.getTeams().then((value) {
        if (value != null) {
          emit(GetTeamsSuccess(teamsresponse: value));
        } else {
          emit(GetTeamsError());
        }
      });
    } catch (error) {
      emit(GetTeamsError());
    }
  }
}
