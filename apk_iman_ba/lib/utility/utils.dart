class Utils {
  String removeEmojis(String text) {
    // Define a list of emojis to be removed
    List<String> emojis = ["🔥", "📖", "🧎", "🍽️"];

    // Remove emojis from the topic string
    for (String emoji in emojis) {
      text = text.replaceAll(emoji, "");
    }

    // Trim any whitespace before or after the topic string
    return text.trim();
  }
}
