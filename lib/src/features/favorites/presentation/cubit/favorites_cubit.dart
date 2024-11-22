import 'package:apk_iman_ba/services/database_service.dart';
import 'package:apk_iman_ba/src/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final DatabaseService _database;

  FavoritesCubit({required DatabaseService database})
      : _database = database,
        super(const FavoritesState()) {
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    emit(state.copyWith(isLoading: true));

    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final questions = await _database.fetchFavorites(user.uid);
        emit(state.copyWith(
          favorites: questions,
          isLoading: false,
        ));
      }
    } catch (error) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> toggleFavorite(String questionId) async {
    await _database.updateFavoriteQuestion(questionId);
    await fetchFavorites(); // Refresh the favorites list
  }
}
