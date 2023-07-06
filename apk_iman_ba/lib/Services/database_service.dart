import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final DatabaseReference _database =
      FirebaseDatabase.instance.ref().child('questions');

  Future<List<Map<String, String>>> searchQuestions(String searchQuery) async {
    final snapshot = await _database
        .child('questions')
        .orderByChild('question')
        .equalTo(searchQuery)
        .once();

    final data = snapshot as Map<dynamic, dynamic>?;

    if (data != null) {
      final List<Map<String, String>> results = [];

      data.forEach((key, value) {
        final question = value['question'] as String?;
        final answer = value['answer'] as String?;
        final topic = value['topic'] as String?;
        final answeredBy = value['answeredBy'] as String?;

        if (question != null &&
            answer != null &&
            topic != null &&
            answeredBy != null) {
          results.add({
            'question': question,
            'answer': answer,
            'topic': topic,
            'answeredBy': answeredBy,
          });
        }
      });

      return results;
    } else {
      return [];
    }
  }

  Future<void> addQuestion(String question, String answer) async {
    final reference = _database.push();
    final questionMap = {
      'question': question,
      'answer': answer,
    };
    await reference.set(questionMap);
  }
}
