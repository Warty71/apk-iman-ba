import 'package:apk_iman_ba/services/database_service.dart';
import 'package:apk_iman_ba/src/features/search/presentation/cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  final DatabaseService _database;

  SearchCubit({required DatabaseService database})
      : _database = database,
        super(const SearchState());

  Future<void> searchQuestions(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(
        searchResults: [],
        searchQuery: query,
        isLoading: false,
      ));
      return;
    }

    emit(state.copyWith(isLoading: true));
    try {
      final results = await _database.filterBySearch(query);
      emit(state.copyWith(
        searchResults: results,
        searchQuery: query,
        isLoading: false,
      ));
    } catch (error) {
      emit(state.copyWith(
        searchResults: [],
        isLoading: false,
      ));
    }
  }

  void clearSearch() {
    emit(const SearchState());
  }
}
