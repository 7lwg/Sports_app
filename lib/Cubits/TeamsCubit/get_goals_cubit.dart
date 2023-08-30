import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sport_app_semicolon/Data/Models/get_goals_model.dart';
import 'package:sport_app_semicolon/Data/Repository/get_teams_data_repo.dart';

part 'get_goals_state.dart';

class GetGoalsCubit extends Cubit<GetGoalsState> {
  GetGoalsCubit() : super(GetGoalsInitial());
  GetGoalsRepo goalsRepo = GetGoalsRepo();

  getGoals() async {
    emit(GetGoalsLoading());

    try {
      await goalsRepo.getGoals().then((value) {
        if (value != null) {
          emit(GetGoalsSuccess(goalsresponse: value));
        } else {
          emit(GetGoalsError());
        }
      });
    } catch (error) {
      emit(GetGoalsError());
    }
  }
}
