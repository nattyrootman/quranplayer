import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'nav_controllers/share_app_controller.dart';

class MyShareButton extends StatelessWidget {
  const MyShareButton({super.key});

  @override
  Widget build(BuildContext context) {
    final share = Get.find<ShareAppController>();
    return ListTile(
      title: const Text("Social Media"),
      subtitle: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          
          ListTile(
           
            onTap: ()=>share.shareWhatsApp(),
            
            title: const Text("WhatsApp"),

           leading: const Icon(Icons.whatshot_sharp),
          ),
          ListTile(
            
            onTap: ()=>share.shareFacebook(),
            title: const Text("Facebook"),
            leading:  const Icon(Icons.facebook),
          ),
          
          ListTile(
            onTap: ()=> share.shareTikTok(),
            title: const Text("TikTok"),
            leading:const Icon(Icons.tiktok)
            ),
         
          ListTile(
            onTap: () =>share.shereApp(),
            title: const Text("Share App"),
            leading: const Icon(Icons.share),
            
          ),
        ],
      ),
    );
  }
}

// Usage:

