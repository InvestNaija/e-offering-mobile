import 'package:flutter/material.dart';
import 'package:invest_naija/constants.dart';

class FilterCheckBox extends StatelessWidget {
  final String name;
  final bool selected;
  final ValueChanged<bool> onChanged;
  const FilterCheckBox({Key key, this.name, this.onChanged, this.selected = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(value: selected, onChanged:onChanged, shape: CircleBorder(), fillColor: MaterialStateProperty.all(Constants.primaryColor),),
        SizedBox(width: 1,),
        Text(this.name,  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Constants.blackColor),),
      ],);
  }
}