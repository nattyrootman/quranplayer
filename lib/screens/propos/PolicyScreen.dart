// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/models/policy.dart';

class Policyscreen extends StatefulWidget {
  const Policyscreen({super.key});

  @override
  State<Policyscreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Policyscreen> {
  Future<PrivacyPolicy> _loadContent() async {
    final String jsonString =
        await rootBundle.loadString('assets/jsons/apropos.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return PrivacyPolicy.fromJson(jsonMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Àpropos'),
      ),
      body: FutureBuilder<PrivacyPolicy>(
        future: _loadContent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final privacyPolicy = snapshot.data!.privacy;
            final translationInfo = snapshot.data!.translations;

            return ListView(children: [
              ListTile(
                title: Text("Politique de Confidentialité"),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(privacyPolicy.dataCollection),
                  Text(privacyPolicy.registration),
                  Text(privacyPolicy.dataSharing),
                  Text(privacyPolicy.commitment)
                ],
              )),

              ListTile(
                  title: Text("Translations"),
                  subtitle: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                    Text(translationInfo.selection),
                    Text("Note",style: TextStyle(fontWeight:FontWeight.bold ,fontSize: 20)),
                    Text(translationInfo.note.description),
                    Text(translationInfo.note.disclaimer),
                    Text(translationInfo.note.recommendation),
                    Text(translationInfo.note.feedback),
                     SizedBox(height: 20),
                    Text("Veillez me contacter si vous avez des questions ou des problèmes"),
                    SizedBox(height: 20),
                    Text("Abathily20@gmail.com"),
                     SizedBox(height: 30),
                  ])),
                  

              // ... autres éléments
            ]);
          } else if (snapshot.hasError) {
            return Text('Erreur : ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
