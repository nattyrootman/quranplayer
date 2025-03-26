import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/models/quran_tlansaltion.dart';

class Addscreen extends StatefulWidget {
  const Addscreen({super.key});

  @override
  State<Addscreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Addscreen> {
  var firebase = FirebaseFirestore.instance;
  List<MyQuran> quran = [];

  List<Verses> myverses = [];

  var load = true;
  var data = {};

  var myverese = [];
  List<String> verseUrls = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    feach();
    //setall();
  }

  feach() async {
    try {
      var base = await firebase.collection("juany").orderBy('id').get();

      for (var i in base.docs) {
        quran.add(MyQuran.fromJson(i.data()));
      }
    } on FirebaseException catch (e) {
      print(e.message!);
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        load = false;
      });
    }
  }

  Future<void> updateVersesField(
      String docId, Map<String, dynamic> verses) async {
    try {
      // Get a reference to your document
      final docRef =
          FirebaseFirestore.instance.collection('NewQuran1').doc(docId);

      // Update only the verses field
      await docRef.update({
        'verses': FieldValue.arrayUnion([verses])
      });

      print('Verses updated successfully');
    } catch (e) {
      print('Error updating verses: $e');
    }
  }

  addVers() async {
    final firestore = FirebaseFirestore.instance.collection('NewQuran1');

    try {
      for (var x = 0; x < 114; x++) {
        var i = quran[x];
        var qur = {
          "audio": "",
          "id": i.id,
          "name": i.name,
          "totalVerses": i.totalVerses,
          "translation": i.translation,
          "transliteration": i.transliteration,
          "type": i.type,
        };

        for (int c = 0; c < 6236; c++) {
          var v = i.verses[c];
          var may = {
            "transliteration": v.transliteration,
            "audio": verseUrls[c],
            "english": v.english,
            "id": v.id,
            "secondAudio": "secondAudio",
            "text": v.text,
            "translation": v.translation
          };

          myverese.add(may);
          await firestore.add(qur);

          qur["verses"] = myverese;
        }
        await firestore.add(qur);

        print('Verses updated successfully');
      }
    } catch (e) {
      Get.rawSnackbar(message: e.toString());
      print(' error ===> ${e.toString()}');
    }
  }

  setall() async {
    try {
      final firestore = FirebaseFirestore.instance.collection('NewQuran2');
      String st =
          "  https://everyayah.com/data/Abdullah_Matroud_128kbps/002000.mp3";

      String baseUrl = "https://everyayah.com/data/Yasser_Ad-Dussary_128kbps/";

      // List to store all the verse URLs
      // List<String> verseUrls = [];

      int getNumberOfVersesInSurah(int surah) {
        // List of the number of verses in each surah (1 to 114)
        // Source: https://en.wikipedia.org/wiki/List_of_surahs_in_the_Quran
        List<int> versesInSurah = [
          7,
          286,
          200,
          176,
          120,
          165,
          206,
          75,
          129,
          109,
          123,
          111,
          43,
          52,
          99,
          128,
          111,
          110,
          98,
          135,
          112,
          78,
          118,
          64,
          77,
          227,
          93,
          88,
          69,
          60,
          34,
          30,
          73,
          54,
          45,
          83,
          182,
          88,
          75,
          85,
          54,
          53,
          89,
          59,
          37,
          35,
          38,
          29,
          18,
          45,
          60,
          49,
          62,
          55,
          78,
          96,
          29,
          22,
          24,
          13,
          14,
          11,
          11,
          18,
          12,
          12,
          30,
          52,
          52,
          44,
          28,
          28,
          20,
          56,
          40,
          31,
          50,
          40,
          46,
          42,
          29,
          19,
          36,
          25,
          22,
          17,
          19,
          26,
          30,
          20,
          15,
          21,
          11,
          8,
          8,
          19,
          5,
          8,
          8,
          11,
          11,
          8,
          3,
          9,
          5,
          4,
          7,
          3,
          6,
          3,
          5,
          4,
          5,
          6
        ];

        // Return the number of verses for the given surah
        return versesInSurah[surah - 1];
      }

      // Generate URLs for all verses
      for (int surah = 1; surah <= 114; surah++) {
        // Get the number of verses in the current surah
        int numberOfVerses = getNumberOfVersesInSurah(surah);

        // Generate URLs for each verse in the surah
        for (int verse = 1; verse <= numberOfVerses; verse++) {
          String surahNumber = surah.toString().padLeft(3, '0');
          String verseNumber = verse.toString().padLeft(3, '0');
          String verseUrl = "$baseUrl$surahNumber$verseNumber.mp3";
          verseUrls.add(verseUrl);

          print('Verses updated successfully');
        }
      }
    } on FirebaseException catch (e) {
      print(e.message!);
      Get.rawSnackbar(message: e.message!);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add"),
        ),
        body: Column(
          children: [
            Center(
                child: Column(children: [
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    setall();
                    //addVers();
                  },
                  child: Text("Add items",
                      style: TextStyle(fontSize: 20, color: Colors.blue)))
            ])),
            SizedBox(height: 20),
            load
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: quran.length,
                        itemBuilder: (context, int index) {
                          return ListTile(
                              title: Text(quran[index].translation));
                        }),
                  ),
          ],
        ));
  }
}
