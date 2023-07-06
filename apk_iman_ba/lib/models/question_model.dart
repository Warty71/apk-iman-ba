class Question {
  String? key;
  String? pitanje;
  String? odgovor;
  String? pitao;
  String? odgovorio;
  String? datum;

  Question(
      {this.key,
      this.pitanje,
      this.odgovor,
      this.pitao,
      this.odgovorio,
      this.datum});

  Question.fromJson(Map<dynamic, dynamic> json) {
    pitanje = json["pitanje"];
    odgovor = json["odgovor"];
    pitao = json["pitao"];
    odgovorio = json["odgovorio"];
    datum = json["datum"];
  }
}
