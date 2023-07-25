class Question {
  final String id;
  final String question;
  final String answer;
  final String askedBy;
  final String answeredBy;
  final String date;
  final String topics;
  final int views;

  Question({
    required this.id,
    required this.question,
    required this.answer,
    required this.askedBy,
    required this.answeredBy,
    required this.date,
    required this.topics,
    required this.views,
  });

  factory Question.fromJson(Map<dynamic, dynamic> json) {
    // Parse the JSON data and create a Question object
    return Question(
      id: json['id'] ?? '',
      question: json['pitanje'] ?? '',
      answer: json['odgovor'] ?? '',
      askedBy: json['email'] ?? '',
      answeredBy: json['odgovorio'] ?? '',
      date: json['datum'] ?? '',
      topics: json['topics'] ?? '',
      views: json['pregledi'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pitanje': question,
      'odgovor': answer,
      'pitao': askedBy,
      'odgovorio': answeredBy,
      'datum': date,
      'topics': topics,
      'pregledi': views,
    };
  }
}
