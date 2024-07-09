import 'package:firebase_database/firebase_database.dart';

class Utils {
  String removeEmojis(String text) {
    // Define a list of emojis to be removed
    List<String> emojis = [
      "🆕",
      "🔥",
      "📖",
      "🧎",
      "🍽️",
      "💰",
      "🕋",
      "💍",
      "🏚",
      "💶",
      "🤲",
      "📜"
    ];

    // Remove emojis from the topic string
    for (String emoji in emojis) {
      text = text.replaceAll(emoji, "");
    }

    // Trim any whitespace before or after the topic string
    return text.trim();
  }

  Future<int> getNumberOfAnswers() async {
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference answersRef = database.ref().child("Privatni Odgovori");

    DatabaseEvent event = await answersRef.once();
    DataSnapshot snapshot = event.snapshot;
    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
    int numberOfAnswers = values.length;

    // Return the number of answers
    return numberOfAnswers;
  }
}
