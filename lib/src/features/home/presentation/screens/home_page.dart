import 'package:apk_iman_ba/src/features/questions/cubit/questions_cubit.dart';
import 'package:apk_iman_ba/src/features/questions/cubit/questions_state.dart';
import 'package:apk_iman_ba/src/shared/common_widgets/custom_fab.dart';
import 'package:apk_iman_ba/src/shared/common_widgets/custom_listview.dart';
import 'package:apk_iman_ba/src/shared/enums/topics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _initializeTabController();
  }

  void _initializeTabController() {
    _tabController = TabController(length: Topic.values.length, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      context.read<QuestionsCubit>().updateCurrentTopic(
            Topic.values[_tabController.index],
            _tabController.index,
          );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: const CustomFAB(shouldRebuild: true),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: SafeArea(
            child: Column(
              children: [
                _buildTopicTabBar(context),
                const SizedBox(height: 10),
                _buildQuestionsList(state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopicTabBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        splashBorderRadius: BorderRadius.circular(30),
        labelStyle: _getTabLabelStyle(true),
        unselectedLabelStyle: _getTabLabelStyle(false),
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: _buildTabIndicator(context),
        tabs: _buildTabsList(),
      ),
    );
  }

  TextStyle _getTabLabelStyle(bool isSelected) {
    return GoogleFonts.poppins(
      color: isSelected ? Colors.white : Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
  }

  BoxDecoration _buildTabIndicator(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: const Color.fromARGB(255, 31, 12, 71),
    );
  }

  List<Widget> _buildTabsList() {
    return Topic.values.map((topic) {
      return Tab(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(topic.label),
        ),
      );
    }).toList();
  }

  Widget _buildQuestionsList(QuestionsState state) {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: Topic.values.map((topic) {
          final questions = state.questionsByTopic[topic] ?? [];
          return CustomListView(
            loadingFlag: state.isLoading,
            itemCount: questions.length,
            questionList: questions,
            useSubtitle: true,
            detailViewSelector: 1,
          );
        }).toList(),
      ),
    );
  }
}
