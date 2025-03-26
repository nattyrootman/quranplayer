// lib/models/app_content.dart
class PrivacyPolicy {
  final Privacy privacy;
  final Translations translations;

  PrivacyPolicy({
    required this.privacy,
    required this.translations,
  });

  factory PrivacyPolicy.fromJson(Map<String, dynamic> json) => PrivacyPolicy(
        privacy: Privacy.fromJson(json['privacy']),
        translations: Translations.fromJson(json['translations']),
      );

  Map<String, dynamic> toJson() => {
        'privacy': privacy.toJson(),
        'translations': translations.toJson(),
      };
}

class Privacy {
  final String dataCollection;
  final String registration;
  final String dataSharing;
  final String commitment;

  Privacy({
    required this.dataCollection,
    required this.registration,
    required this.dataSharing,
    required this.commitment,
  });

  factory Privacy.fromJson(Map<String, dynamic> json) => Privacy(
        dataCollection: json['data_collection'],
        registration: json['registration'],
        dataSharing: json['data_sharing'],
        commitment: json['commitment'],
      );

  Map<String, dynamic> toJson() => {
        'data_collection': dataCollection,
        'registration': registration,
        'data_sharing': dataSharing,
        'commitment': commitment,
      };
}

class Translations {
  final String sources;
  final String selection;
  final String feedback;
  final Note note;

  Translations({
    required this.sources,
    required this.selection,
    required this.feedback,
    required this.note,
  });

  factory Translations.fromJson(Map<String, dynamic> json) => Translations(
        sources: json['sources'],
        selection: json['selection'],
        feedback: json['feedback'],
        note: Note.fromJson(json['note']),
      );

  Map<String, dynamic> toJson() => {
        'sources': sources,
        'selection': selection,
        'feedback': feedback,
        'note': note.toJson(),
      };
}

class Note {
  final String description;
  final String disclaimer;
  final String recommendation;
  final String feedback;

  Note({
    required this.description,
    required this.disclaimer,
    required this.recommendation,
    required this.feedback,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        description: json['description'],
        disclaimer: json['disclaimer'],
        recommendation: json['recommendation'],
        feedback: json['feedback'],
      );

  Map<String, dynamic> toJson() => {
        'description': description,
        'disclaimer': disclaimer,
        'recommendation': recommendation,
        'feedback': feedback,
      };
}