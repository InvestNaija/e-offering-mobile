
import 'package:intl/intl.dart';

class FormatterUtil{
  static String formatNumber(dynamic number){
    NumberFormat formatter = NumberFormat("#,###,###.00", "en_US");
    return formatter.format(number);
  }

  static String formatName(String name){
    if(name == null || name == '') return name;
    var list = name.toLowerCase().split(" ");
    list..removeWhere((element) => element.isEmpty);
    return list.map((s) => '${s[0].toUpperCase()}${s.substring(1)}').join (" ");
  }

  static String formatDate(String date){
    if(date == null) return date;
    List<String> split = date.split('-');
    return '${split[1]}-${split[0]}-${split[2]}';
  }
}