enum Topic {
  novo('🆕Novo'),
  //popularno('🔥Popularno'),
  kuran('📖Kur\'an'),
  namaz('🧎Namaz'),
  post('🍽️Post'),
  zekat('💰Zekat'),
  hadz('🕋Hadž i Umra'),
  bracnoPravo('💍Bračno Pravo'),
  nasljednoPravo('🏚Nasljedno Pravo'),
  lijecenjeKuranom('📖Liječenje Kur\'anom'),
  trgovina('💶Trgovina'),
  vjerovanje('🤲Islamsko Vjerovanje'),
  hadis('📜Hadis'),
  ostalo('Ostalo');

  final String label;
  const Topic(this.label);

  @override
  String toString() => label;

  static Topic fromString(String label) {
    return Topic.values.firstWhere(
      (topic) => topic.label == label,
      orElse: () => Topic.novo,
    );
  }

  String get withoutEmoji {
    final emojiRegex = RegExp(
      r'[\u{1F300}-\u{1F9FF}][\u{FE00}-\u{FE0F}]?|'
      r'[\u{2600}-\u{26FF}][\u{FE00}-\u{FE0F}]?|'
      r'[\u{2700}-\u{27BF}][\u{FE00}-\u{FE0F}]?',
      unicode: true,
    );
    return label.replaceAll(emojiRegex, '').trim();
  }
}
