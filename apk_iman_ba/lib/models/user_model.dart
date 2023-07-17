class Users {
  String id;
  String email;
  String lastQuestionTime;
  List<String> favoriteQuestions;
  List<String> personalQuestions;
  List<String> onHoldQuestions;

  Users({
    required this.id,
    required this.email,
    required this.lastQuestionTime,
    this.favoriteQuestions = const [],
    this.personalQuestions = const [],
    this.onHoldQuestions = const [],
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      email: json['email'],
      lastQuestionTime: json['zadnjePitanje'],
      favoriteQuestions: List<String>.from(json['favoriteQuestions']),
      personalQuestions: List<String>.from(json['personalQuestions']),
      onHoldQuestions: List<String>.from(json['naČekanjuPitanja']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'zadnjePitanje': lastQuestionTime,
      'favoriti': favoriteQuestions,
      'mojaPitanja': personalQuestions,
      'naČekanjuPitanja': onHoldQuestions,
    };
  }
}
