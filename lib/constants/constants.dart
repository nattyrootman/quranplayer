import 'package:audio_service/audio_service.dart';



  const fr = "https://api.alquran.cloud/v1/quran/fr.leclerc";
  const english = "https://api.alquran.cloud/v1/quran/en.walk";
    const String baseUrl = 'http://api.alquran.cloud/v1/quran/ar.alafasy';

const mediaItem = MediaItem(
  id: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
  album: "Science Friday",
  title: "A Salute To Head-Scratching Science",
  artist: "Science Friday and WNYC Studios",
  duration: Duration(milliseconds: 5739820),
 
);

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return '$minutes:$seconds';
}




