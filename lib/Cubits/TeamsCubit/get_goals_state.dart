part of 'get_goals_cubit.dart';

@immutable
sealed class GetGoalsState {}

final class GetGoalsInitial extends GetGoalsState {}

final class GetGoalsLoading extends GetGoalsState {}

final class GetGoalsSuccess extends GetGoalsState {
  final GetGoalsModel goalsresponse;
  GetGoalsSuccess({required this.goalsresponse});
}

final class GetGoalsError extends GetGoalsState {}
