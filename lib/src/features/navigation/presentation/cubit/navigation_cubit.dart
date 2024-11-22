import 'package:apk_iman_ba/src/features/navigation/presentation/cubit/navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  void setIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
