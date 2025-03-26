import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/screens/home_screen/home_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareAppController extends GetxController {
  static ShareAppController get to => Get.find();

  void shareWhatsApp() async {
    var phoneNumber = '${00213551507739}';

    final encodedMessage = Uri.encodeComponent("i want to chat with you");

    final whatsappUrl =
        "whatsapp://send?phone=$phoneNumber&text=$encodedMessage";
    //final webWhatsappUrl = "https://wa.me/$phoneNumber?text=$encodedMessage";

    _launchUrl(whatsappUrl);
  }

  Future<void> shareFacebook() async {
    String profileId = 'astrisk';
    final url = 'fb://profile/$profileId';
    final mobileUrl = 'fb://profile/$profileId';
    final webUrl = 'https://www.facebook.com/$profileId';
    
     if(kIsWeb){
        await _launchUrl(webUrl);
     }else{
       await _launchUrl(mobileUrl);
     }
   
  }

  Future<void> shareTikTok() async {
    var rootmancoder = "rootmancoder";
    final tikTokUrl = "https://www.tiktok.com/@$rootmancoder";

    await _launchUrl(tikTokUrl);
  }

  shereApp() async {
    final result = await Share.share('https://qurany-8df6f.web.app',
        subject: 'Share my appp'
            'https://qurany-8df6f.web.app');

    if (result.status == ShareResultStatus.success) {
      ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(const SnackBar(
          content: Text('Link copied to clipboard!'),
          duration: Duration(seconds: 3)));
    } else {
      Get.snackbar("title", "It fail");
    }
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.platformDefault);
        Navigator.pop(Get.overlayContext!);
      Get.offAll(() => const HomeScreen());
    } else {
      Get.showSnackbar(GetSnackBar(
          duration: const Duration(seconds: 4),
          title: 'Error',
          messageText: Text('Could not launch $urlString')));
    }
  }
}

// Usage:

