import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sport_app_semicolon/Screens/LoginScreen.dart';

part 'circular_indicator_state.dart';

class CircularIndicatorCubit extends Cubit<CircularIndicatorState> {
  CircularIndicatorCubit() : super(CircularIndicatorInitial());

  var isLoading = false;

  void Circular() async {
    isLoading = true;
    emit(CircularIndicatorInitial());
    await Future.delayed(Duration(seconds: 3), () {
      isLoading = false;
      emit(CircularIndicator());
    });
  }
}
