
class MyQuran {
  final String audio;
  final int id;
  final String name;
  final int totalVerses;
 // final
  String translation;
  final String transliteration;
  final String type;
   List<Verses> verses;

  // Constructor
  MyQuran({
    required this.audio,
    required this.id,
    required this.name,
    required this.totalVerses,
    required this.translation,
    required this.transliteration,
    required this.type,
    required this.verses,
  });

  Map<String, dynamic> toJson() {
    return {
       'audio': audio,
     
      'id': id,
      'name': name,
      'total_verses': totalVerses,
      'translation': translation,
      'transliteration': transliteration,
      'type': type,
      'verses': verses,
    };
  }

  factory MyQuran.fromJson(  Map<String, dynamic> json) {
 
    return MyQuran(
      audio: json["audio"]??"audio",
      id: json['id']  ?? 0,
      name: json['name'] as String? ??"name",
      totalVerses: json['total_verses'] as int? ??0,
      translation: json['translation'] as String? ??"translation",
      transliteration: json['transliteration'] as String? ??"transliteration",
      type: json['type'] as String? ??"type",
      verses: (json['verses'] as List).map((verse)=>Verses.fromJson(verse)).toList(),
    
    );
  }
}

class Verses {
  // Properties
  final String transliteration;
 String audio;
  final String english;
  final int id;
  final String secondAudio;
  final String text;
  final String translation;

  // Constructor
  Verses({
    required this.transliteration,
    required this.audio,
    required this.english,
    required this.id,
    required this.secondAudio,
    required this.text,
    required this.translation,
  });

  factory Verses.fromJson(Map<String, dynamic> json) {
    return Verses(
      transliteration: json['transliteration'] as String? ??"",
      audio: json['audio'] as String? ??"",
      english: json['english'] as String? ??"",
      id: json['id'] as int? ??0,
      secondAudio: json['secondAudio'] as String? ??"",
      text: json['text'] as String? ??"",
      translation: json['translation'] as String? ??"",
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'transliteration': transliteration,
      'audio': audio,
      'english': english,
      'id': id,
      'secondAudio': secondAudio,
      'text': text,
      'translation': translation,
    };
  }
}



/*var ver = Verses(
              transliteration: quran[i].verses[v].transliteration,
              audio: verseUrls[v],
              english: quran[i].verses[v].english,
              id: quran[i].verses[v].id,
              secondAudio: "secondAudio",
              text: quran[i].verses[v].text,
              translation: quran[i].verses[v].translation);
          var h = ver.toJson();*/




