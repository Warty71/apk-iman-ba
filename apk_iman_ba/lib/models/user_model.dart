class Users {
  String id;
  String email;
  List<String> favoriteQuestions;
  List<String> personalQuestions;

  Users({
    required this.id,
    required this.email,
    this.favoriteQuestions = const [],
    this.personalQuestions = const [],
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      email: json['email'],
      favoriteQuestions: List<String>.from(json['favoriteQuestions']),
      personalQuestions: List<String>.from(json['personalQuestions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'favoriti': favoriteQuestions,
      'mojaPitanja': personalQuestions,
    };
  }
}
