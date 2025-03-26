// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/audio_controller/player_contrroler.dart';
import 'package:myapp/screens/nav_bars/share_button.dart';
import 'package:myapp/screens/propos/PolicyScreen.dart';
import 'package:myapp/screens/widgets/myfull_dialog.dart';
import 'package:myapp/utilies/colors.dart';

import '../../favorite_screen/favorite_screen.dart';

class MainNav extends StatelessWidget {
  const MainNav({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AudioPlayerController>();
    return Drawer(
      elevation: 10,
      child: ListView(scrollDirection: Axis.vertical, children: [
        DrawerHeader(
            decoration: BoxDecoration(gradient: MyColor.linear4),
            child: Stack(
              children: [
                Positioned(top: 3, left: 5, child: Text('QuranPlayer')),
                Positioned(
                    right: 50,
                    bottom: 10,
                    child: Image.asset("assets/koran.png", height: 100))
              ],
            )),
        ExpansionTile(title: Text("Traduction-Anglais"), children: [
          ListTile(
            onTap: () {
              controller.collection.value = 'Saheeh_english';
            },
            title: Text("Mishary Al Afassy"),
            subtitle: Text("Traduit par Ibrahim Walk",
                style: TextStyle(fontSize: 10)),
            leading: Image.asset(
              "assets/uk.png",
              height: 20,
              width: 20,
            ),
          ),
          ListTile(
            onTap: () {
               Navigator.pop(context);
              controller.collection.value = 'abdurahman_sudais';
             
            },
           
            title: Text("Abdurrahman Sudais"),
            subtitle: Text("Traduit par Ibrahim Walk",
                style: TextStyle(fontSize: 10)),
            leading: Image.asset(
              "assets/uk.png",
              height: 20,
              width: 20,
            ),
          ),
        ]),
        // Divider(),
        ExpansionTile(title: Text("Traduction-Français"), children: [
          ListTile(
            onTap: () {
              controller.collection.value = 'french_saheeh';
            },
            title: Text("Mishary Al Afassy"),
            subtitle: Text("Traduit par Yusuf Leclerc",
                style: TextStyle(fontSize: 10)),
            leading : Image.asset(
              "assets/france.png",
              height: 20,
              width: 20,
            ),
          ),
          ListTile(
            onTap: () {
               Navigator.pop(context);
              controller.collection.value = 'Maher_French';
            },
            
            title: Text("Maher Muaqli"),
            subtitle: Text("Traduit par Yusuf Leclerc",
                style: TextStyle(fontSize: 10)),
            leading: Image.asset(
              "assets/france.png",
              height: 20,
              width: 20,
            ),
          ),
        ]),
        ListTile(
          title: Text("Favoris"),
          leading: Icon(Icons.favorite_border_sharp),
          onTap: () {
            Navigator.pop(context);
            Get.to(() => FavoriteScreen());
          },
        ),

        ListTile(
          onTap: () {
             Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context) {
                  return MyFullDialog();
                });
            //  Get.to(() => DetailScreen());
          },
          title: Text("Paramètres"),
          leading: Icon(Icons.settings),
        ),
        Divider(),
        ListTile(
          onTap: () {
             Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context) {
                  return Policyscreen();
                });
          },
          title: Text("À Propos"),
          leading: Icon(Icons.info),
        ),
        Divider(),

        MyShareButton()
      ]),
    );
  }
}
