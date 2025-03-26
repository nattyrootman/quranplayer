// lib/models/surah.dart



class QuranAudio {
  final int number;        // Surah number
  final String name;       // Arabic name
  final String englishName;
  final String englishNameTranslation;
  final List<Ayah> ayahs;  // List of verses with audio

  QuranAudio({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.ayahs,
  });

  factory QuranAudio.fromJson(Map<String, dynamic> json) {
    return QuranAudio(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
      ayahs: (json['ayahs'] as List)
          .map((ayah) => Ayah.fromJson(ayah))
          .toList(),
    );
  }
}

class Ayah {
  final int number;
  final String text;
  final String audio;     // Audio URL for this verse
  final int numberInSurah;

  Ayah({
    required this.number,
    required this.text,
    required this.audio,
    required this.numberInSurah,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      number: json['number'],
      text: json['text'],
      audio: json['audio'],
      numberInSurah: json['numberInSurah'],
    );
  }
}