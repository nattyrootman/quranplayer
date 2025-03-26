import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/themes/theme_controller.dart';


class MyStyles{

      final controller = Get.put(ThemeController());

  static final  arabTtile=GoogleFonts.amiriQuran(fontSize: 28);
  static final  arabMedium=GoogleFonts.amiriQuran(fontSize:24,wordSpacing: 6,height: 2.5);
  static final  arabSmall=GoogleFonts.amiriQuran(fontSize: 20);
  static var  arab=GoogleFonts.amiri(fontSize: 24,wordSpacing: 6,height: 2.0);


// Suggested code may be subject to a license. Learn more: ~LicenseLog:4261182069.
  static final  openSansTtle=GoogleFonts.openSans(fontSize: 28);
  static final openSansMd=GoogleFonts.openSans(fontSize: 24);
  static final  opensanSmll=GoogleFonts.openSans(fontSize: 16);

  //Google Robo font
  static final  robotoTitle=GoogleFonts.roboto(fontSize: 28);
  static final  robotoMediums=GoogleFonts.roboto(fontSize:24);
  static final  robotoSmal=GoogleFonts.roboto(fontSize:16);

  //AmiriQuran-Regular




//Google Robo font
 static final  smallVerses=GoogleFonts.amiriQuran(fontSize: 24);
 static final  smallTranslation=GoogleFonts.roboto(fontSize: 16,);
 static final  smallEnglish=GoogleFonts.openSans(fontSize: 16);

 //static final =TextStyle();






}