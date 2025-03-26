class SurahSingleAudio {
  final String audio;
  final int id;

  final String name;
  final int totalVerses;
  final String translation;
  final String transliteration;
  final String type;
  final List<SingleVerse> verses;

  SurahSingleAudio({
    required this.audio,
    required this.id,
    required this.name,
    required this.totalVerses,
    required this.translation,
    required this.transliteration,
    required this.type,
    required this.verses,
  });

  // Convert a Surah object to a Map (for JSON encoding)
  Map<String, dynamic> toJson() {
    return {
      'audio': audio,
      'id': id,
      'name': name,
      'total_verses': totalVerses,
      'translation': translation,
      'transliteration': transliteration,
      'type': type,
      'verses': verses.map((verse) => verse.toJson()).toList(),
    };
  }

  // Create a Surah object from a Map (from JSON)
  factory SurahSingleAudio.fromJson(Map<String, dynamic> json) {
    return SurahSingleAudio(
      audio: json['audio'],
      id: json['id'],
      name: json['name'],
      totalVerses: json['total_verses'],
      translation: json['translation'],
      transliteration: json['transliteration'],
      type: json['type'],
      verses: (json['verses'] as List)
          .map((verse) => SingleVerse.fromJson(verse))
          .toList(),
    );
  }
}

// verses Classtes
class SingleVerse {
  final int id;
  final String text;
  final String translation;
  final String english;
  final String transliteration;
  final String audio;

  SingleVerse({
    required this.id,
    required this.text,
    required this.translation,
    required this.english,
    required this.transliteration,
    required this.audio,

  });

  // Convert a Verse object to a Map (for JSON encoding)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'translation': translation,
      'english': english,
      'transliteration': transliteration,
      'audio': audio,
    };
  }

  // Create a Verse object from a Map (from JSON)
  factory SingleVerse.fromJson(Map<String, dynamic> json) {
    return SingleVerse(
      id: json['id'],
      text: json['text'],
      translation: json['translation'],
      english: json['english'],
      transliteration: json['transliteration']??"",
      audio: json['audio'],
    );
  }
}
