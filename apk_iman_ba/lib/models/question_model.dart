class Question {
  final String question;
  final String answer;
  final String askedBy;
  final String answeredBy;
  final DateTime date;

  Question({
    required this.question,
    required this.answer,
    required this.askedBy,
    required this.answeredBy,
    required this.date,
  });

  factory Question.fromJson(Map<dynamic, dynamic> json) {
    // Parse the JSON data and create a Question object
    return Question(
      question: json['pitanje'] ?? '',
      answer: json['odgovor'] ?? '',
      askedBy: json['pitao'] ?? '',
      answeredBy: json['odgovorio'] ?? '',
      date: json['datum'] != null
          ? DateTime.parse(json['datum'])
          : DateTime.now(),
    );
  }
}
