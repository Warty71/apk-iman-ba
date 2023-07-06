import 'package:apk_iman_ba/models/question_model.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Baza");

  Future<List<Question>> searchQuestions(String searchText) async {
    try {
      List<Question> questionList = [];
      DatabaseEvent event = await dbRef.child('Questions').once();
      DataSnapshot snapshot = event.snapshot;
      dynamic data = snapshot.value;
      if (data != null) {
        data.forEach((key, value) {
          Question question = Question.fromJson(value);
          if (question.question
              .toLowerCase()
              .contains(searchText.toLowerCase())) {
            questionList.add(question);
          }
        });
      }
      return questionList;
    } catch (error) {
      print('Failed to retrieve questions: $error');
      return [];
    }
  }
}
