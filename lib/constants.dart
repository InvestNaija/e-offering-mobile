import 'package:flutter/material.dart';

class Constants {
  static const Color primaryColor = Color.fromARGB(255,220, 103,47);
  static const Color secondaryColor = Color.fromARGB(255, 234,234,234);
  static const Color pink65 = Color.fromARGB(180, 240, 105, 105);
  static const Color blackColor = Color.fromARGB(255, 4, 4, 21);
  static const Color whiteColor = Color.fromARGB(255, 255, 255, 255);
  static const Color dropdownBorderColor = Color.fromARGB(255,209,224,233);
  static const Color textFieldFillColor = Color.fromRGBO(15, 36, 47, 0.02);
  static const Color textFieldBorderColor = Color.fromARGB(150, 224, 231, 234);
  static const Color whiteColorA2 = Color.fromARGB(55, 255, 255, 255);
  static const Color cardShadowColor = Color.fromARGB(50,234,241,244);
  static const Color dropdownBackgroundColor = Color.fromARGB(10,15,36,47);
  static const Color fontColor2 = Color.fromARGB(120, 30,31,32,);
  static const Color primaryColorA20 = Color.fromARGB(51,220, 103,47);
  static const Color leadColor = Color.fromARGB(255,30,31,32);
  static const Color errorAlertColor = Color.fromARGB(255,205,26,17);
  static const Color walrusColor = Color.fromARGB(255,154,154,155);
  static const Color borderInactiveColor = Color.fromARGB(255,214,224,233);
  static const Color neutralColor = Color.fromARGB(255,154,154,155);
  static const Color iconsColor = Color.fromARGB(255,16,16,16);//border: 1.5px solid 4,4,21,1
  static const Color leadBorderColor = Color.fromARGB(25,4,4,21);
  static const Color bleachSilkColor = Color.fromARGB(255,242,242,242);
  static const Color successColor = Color.fromARGB(255,0,186,136);
  static const Color greenColor = Color.fromARGB(255,69,161,150);
  static const Color navyBlueColor = Color.fromARGB(255,15,36,47);
  static const Color gray6Color = Color.fromARGB(255,242,242,242);
  static const Color yellowColor = Color.fromARGB(255,249,206,11);
  static const Color yellowBrandColor = Color.fromARGB(100,251, 208, 13,);
  static const Color gray4Color = Color.fromARGB(255,189,189,189);
  static const Color gray7Color = Color.fromARGB(255,116,116,116);
  static const Color tealColor = Color.fromARGB(255,21,155,157);
  static const Color dashboardBackgroundColor = Color.fromARGB(255,234,241,244);
  static const Color innerBorderColor = Color.fromARGB(255,0,43,67);
  static const Color textDividerColor = Color.fromARGB(255,224,231,234);

  static const Map<int, Color> primaryColorGrades =
  {
    50:Color.fromRGBO(234,241,244, .1),
    100:Color.fromRGBO(234,241,244, .2),
    200:Color.fromRGBO(234,241,244, .3),
    300:Color.fromRGBO(234,241,244, .4),
    400:Color.fromRGBO(234,241,244, .5),
    500:Color.fromRGBO(234,241,244, .6),
    600:Color.fromRGBO(234,241,244, .7),
    700:Color.fromRGBO(234,241,244, .8),
    800:Color.fromRGBO(234,241,244, .9),
    900:Color.fromRGBO(234, 241, 244, 1.0),
  };
  static const MaterialColor primaryColorMaterial = MaterialColor(0xFFEAF1F4, primaryColorGrades);
}