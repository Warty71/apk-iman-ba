import 'package:apk_iman_ba/State%20Management/user_state.dart';
import 'package:apk_iman_ba/models/question_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  // Reference to the Realtime Database
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  // Method used to ask a question
  Future<void> askQuestions(BuildContext context, question) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      DatabaseReference korisnickaPitanjaRef =
          dbRef.child('Korisnicka Pitanja').push();
      String? questionId = korisnickaPitanjaRef.key;

      DatabaseReference korisnikRef = dbRef.child('Korisnici').child(user!.uid);
      final DatabaseEvent event = await korisnikRef.once();
      final dynamic korisnikData = event.snapshot.value;

      await korisnickaPitanjaRef.set({
        'pitanje': question,
        // ignore: use_build_context_synchronously
        'korisnik': Provider.of<UserState>(context, listen: false)
            .user!
            .email
            .toString(),
        // Additional fields or data associated with the question
      });

      // When was the last question asked?
      await korisnikRef.update({
        'zadnjePitanje': DateTime.now().toIso8601String(),
      });

      if (korisnikData != null && korisnikData is Map<dynamic, dynamic>) {
        final List<String> onHoldQuestions =
            List<String>.from(korisnikData['naČekanjuPitanja'] ?? []);

        // Add the question to favorites
        onHoldQuestions.add(questionId!);

        await korisnikRef.child('naČekanjuPitanja').set(onHoldQuestions);
      }
    } catch (error) {
      // Handle the error if writing to the database fails
      // ignore: avoid_print
      print('Failed to ask question: $error');
    }
  }

  // Method used to query the database using a search text (String)
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

// Method used to query the database using a topic (String)
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

// Method used to query the database by views (Integer)
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

// Method used to update the views of a question each time it is opened
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

// Method used to select/deselect a question as a Favorite
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

// Method used to check whether a question is a Favorite
  Future<bool> checkFavoriteStatus(String questionId) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final DatabaseReference userRef =
          dbRef.child("Korisnici").child(user!.uid);

      final DatabaseEvent event = await userRef.once();
      final dynamic userData = event.snapshot.value;
      if (userData != null && userData is Map<dynamic, dynamic>) {
        final List<String> favoriteQuestions =
            List<String>.from(userData['favoriteQuestions'] ?? []);

        return favoriteQuestions.contains(questionId);
      }
      // ignore: empty_catches
    } catch (error) {}
    return false;
  }

// Method used to fetch the Favorite questions
  Future<List<Question>> fetchFavorites(String userId) async {
    final DatabaseReference userRef =
        FirebaseDatabase.instance.ref().child("Korisnici").child(userId);
    final DatabaseEvent event = await userRef.once();
    final DataSnapshot snapshot = event.snapshot;
    final dynamic userData = snapshot.value;

    if (userData != null && userData is Map<dynamic, dynamic>) {
      final List<String> favoriteQuestionIds =
          List<String>.from(userData['favoriteQuestions'] ?? []);

      final List<Question> favoriteQuestions = [];

      for (String questionId in favoriteQuestionIds) {
        final DatabaseEvent event =
            await dbRef.child("Pitanja i Odgovori").child(questionId).once();
        final DataSnapshot snapshot = event.snapshot;
        final dynamic questionData = snapshot.value;
        if (questionData != null) {
          final Question question = Question.fromJson(questionData);
          favoriteQuestions.add(question);
        }
      }
      return favoriteQuestions;
    } else {
      return [];
    }
  }

// Method used to fetch personal questions
  Future<List<Question>> fetchMyQuestions(String userId) async {
    final DatabaseReference userRef =
        FirebaseDatabase.instance.ref().child("Korisnici").child(userId);
    final DatabaseEvent event = await userRef.once();
    final DataSnapshot snapshot = event.snapshot;
    final dynamic userData = snapshot.value;

    if (userData != null && userData is Map<dynamic, dynamic>) {
      final List<String> personalQuestionIds =
          List<String>.from(userData['personalQuestions'] ?? []);

      final List<Question> personalQuestions = [];

      for (String questionId in personalQuestionIds) {
        final DatabaseEvent event =
            await dbRef.child("Pitanja i Odgovori").child(questionId).once();
        final DataSnapshot snapshot = event.snapshot;
        final dynamic questionData = snapshot.value;
        if (questionData != null) {
          final Question question = Question.fromJson(questionData);
          personalQuestions.add(question);
        }
      }
      return personalQuestions;
    } else {
      return [];
    }
  }

// Method used to fetch the length of the personal questions list
  Future<String> fetchMyQuestionsLength(String userId) async {
    final DatabaseReference pesronalQuestionsRef =
        dbRef.child("Korisnici").child(userId).child('personalQuestion');

    DatabaseEvent event = await pesronalQuestionsRef.once();
    DataSnapshot snapshot = event.snapshot;
    dynamic personalQuestionsData = snapshot.value;

    if (personalQuestionsData != null && personalQuestionsData is List) {
      int count = personalQuestionsData.length;
      return count.toString();
    } else {
      return 0.toString();
    }
  }

  // Method used to fetch onHold questions
  Future<List<Question>> fetchOnHoldQuestions(String userId) async {
    final DatabaseReference userRef =
        FirebaseDatabase.instance.ref().child("Korisnici").child(userId);
    final DatabaseEvent event = await userRef.once();
    final DataSnapshot snapshot = event.snapshot;
    final dynamic userData = snapshot.value;

    if (userData != null && userData is Map<dynamic, dynamic>) {
      final List<String> onHoldQuestionIds =
          List<String>.from(userData['naČekanjuPitanja'] ?? []);

      final List<Question> onHoldQuestions = [];

      for (String questionId in onHoldQuestionIds) {
        final DatabaseEvent event =
            await dbRef.child("Korisnicka Pitanja").child(questionId).once();
        final DataSnapshot snapshot = event.snapshot;
        final dynamic questionData = snapshot.value;
        if (questionData != null) {
          final Question question = Question.fromJson(questionData);
          onHoldQuestions.add(question);
        }
      }
      return onHoldQuestions;
    } else {
      return [];
    }
  }
}
