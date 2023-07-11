import 'package:apk_iman_ba/models/question_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  //DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Baza");
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  Future<List<Question>> filterBySearch(String searchText) async {
    try {
      List<Question> questionList = [];
      DatabaseEvent event = await dbRef.child('Pitanja i Odgovori').once();
      DataSnapshot snapshot = event.snapshot;
      dynamic data = snapshot.value;
      if (data != null) {
        data.forEach((key, value) {
          Question question = Question.fromJson(value);
          if ((question.question
                  .toLowerCase()
                  .contains(searchText.toLowerCase())) &&
              (searchText.length >= 3)) {
            questionList.add(question);
          }
        });
      }
      return questionList;
    } catch (error) {
      // ignore: avoid_print
      print('Failed to retrieve questions: $error');
      return [];
    }
  }

  Future<List<Question>> filterByTopic(String topic) async {
    try {
      DatabaseEvent event = await dbRef
          .child("Pitanja i Odgovori")
          .orderByChild('datum')
          .limitToLast(10)
          .once();

      final questionsMap = event.snapshot.value as Map<dynamic, dynamic>;

      final filteredQuestions = questionsMap.entries
          .where((entry) {
            final question = entry.value;
            final topics = question['topics'];
            return topics != null && topics.toString().contains(topic);
          })
          .map((entry) => Question.fromJson(entry.value))
          .toList();

      // ignore: avoid_function_literals_in_foreach_calls
      filteredQuestions.forEach((question) {});

      return filteredQuestions;
    } catch (error) {
      return [];
    }
  }

  Future<List<Question>> filterByViews() async {
    try {
      final DatabaseEvent event = await dbRef
          .child("Pitanja i Odgovori")
          .orderByChild("pregledi")
          .limitToLast(10)
          .once();
      final DataSnapshot snapshot = event.snapshot;
      final dynamic data = snapshot.value;
      if (data != null && data is Map<dynamic, dynamic>) {
        final List<Question> popularQuestions = data.entries.map((entry) {
          final Question question = Question.fromJson(entry.value);
          return question;
        }).toList();

        popularQuestions.sort((a, b) => b.views.compareTo(a.views));
        return popularQuestions;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<void> updateViews(String fieldToMatch, dynamic valueToMatch,
      String fieldToUpdate, dynamic newValue) async {
    final Query query = dbRef
        .child("Pitanja i Odgovori")
        .orderByChild(fieldToMatch)
        .equalTo(valueToMatch);
    final DatabaseEvent event = await query.once();
    final DataSnapshot snapshot = event.snapshot;
    final Map<dynamic, dynamic> entries =
        snapshot.value as Map<dynamic, dynamic>;
    if (entries.isNotEmpty) {
      final String entryKey = entries.keys.first;
      final DatabaseReference entryRef =
          dbRef.child("Pitanja i Odgovori").child(entryKey);
      await entryRef.child(fieldToUpdate).set(newValue + 1);
    } else {}
  }

  Future<void> updateFavoriteQuestion(String questionId) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child("Korisnici").child(user.uid);

        final DatabaseEvent event = await userRef.once();
        final dynamic userData = event.snapshot.value;

        if (userData != null && userData is Map<dynamic, dynamic>) {
          final List<String> favoriteQuestions =
              List<String>.from(userData['favoriteQuestions'] ?? []);

          if (favoriteQuestions.contains(questionId)) {
            // Remove the question from favorites
            favoriteQuestions.remove(questionId);
          } else {
            // Add the question to favorites
            favoriteQuestions.add(questionId);
          }

          await userRef.child('favoriteQuestions').set(favoriteQuestions);
        }
      }
    } catch (error) {
      // ignore: avoid_print
      print('Failed to toggle favorite question: $error');
    }
  }
}
