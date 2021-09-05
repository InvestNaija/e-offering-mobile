import 'package:flutter/material.dart';
import 'package:invest_naija/constants.dart';

class CustomCheckbox extends StatelessWidget {
  final Function(bool) onTap;
  final bool hasAcceptedTermsAndConditions;
  const CustomCheckbox({Key key, this.onTap, this.hasAcceptedTermsAndConditions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> this.onTap(!hasAcceptedTermsAndConditions),
      child: Container(
        width: 17,
        height: 17,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Constants.blackColor)
        ),
        child: Center(child: Offstage(
            offstage: !hasAcceptedTermsAndConditions,
            child: Icon(Icons.check, color: Constants.blackColor, size: 12,))),
      ),
    );
  }
}
