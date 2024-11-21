import 'package:apk_iman_ba/src/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:apk_iman_ba/src/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:apk_iman_ba/src/shared/common_widgets/custom_fab.dart';
import 'package:apk_iman_ba/src/shared/common_widgets/custom_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: const CustomFAB(shouldRebuild: true),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Sačuvana pitanja",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.32,
                            color: const Color(0xFF201E22),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CustomListView(
                    loadingFlag: state.isLoading,
                    itemCount: state.favorites.length,
                    questionList: state.favorites,
                    useSubtitle: true,
                    detailViewSelector: 1,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
