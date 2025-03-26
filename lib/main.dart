import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:myapp/audio_controller/audio_initalizer_controller.dart';
import 'package:myapp/audio_controller/lifecycle_controller.dart';
import 'package:myapp/audio_controller/player_contrroler.dart';
import 'package:myapp/audio_controller/singleerplayer.dart';
import 'package:myapp/favorite_screen/favorite_controller/favorite_controller.dart';
import 'package:myapp/screens/nav_bars/nav_controllers/share_app_controller.dart';
import 'package:myapp/screens/params_screen/param_controller.dart';
import 'package:myapp/service/query_items.dart';
import 'package:myapp/themes/theme_controller.dart';
import 'firebase_options.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/propos/controllers/propos.dart';
import 'service/quran_translation_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await JustAudioBackground.init(
    androidNotificationIcon: 'mipmap/ic_launcher',
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationClickStartsActivity: true,
    androidNotificationOngoing: true,
  );

  Get.put(ThemeController(), permanent: true);
  Get.put(AudioSetUpController(), permanent: true);
  Get.put(SinglePlayerController(), permanent: true);
  Get.put(ParamController(), permanent: true);
  Get.put(ShareAppController(), permanent: true);
  Get.put(LifecycleController(), permanent: true);
  Get.put(ProposController(), permanent: true);
  Get.put(FavoriteController(), permanent: true);
  Get.put(AudioPlayerController(), permanent: true);
  Get.put(QuranTranslationController());
  Get.put(QueryItemsController());
  if (!kIsWeb) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final themeController = Get.find<ThemeController>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'QuranPlayer',

          theme: ThemeData.light(),

          themeMode:
              themeController.isDark.value ? ThemeMode.dark : ThemeMode.light,

          darkTheme: themeController.getTheme(),
          home: const HomeScreen(),
          //
        ));
  }
}




//com.ryanheise.audioservice.AudioServiceActivity

//flutter build apk --split-per-abi



    