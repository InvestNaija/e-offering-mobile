import 'package:flutter/material.dart';
import 'package:invest_naija/constants.dart';

class PasswordEligibilityComponent extends StatelessWidget {
  final String password;
  const PasswordEligibilityComponent({Key key, this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle = const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xff212b4c));
    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length >= 8;
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              NfsCheckBox(borderRadius: 10, checked: hasMinLength,),
              SizedBox(width: 10,),
              Text('At least 8 characters', style: defaultStyle,)
            ],
          ),
          SizedBox(height: 6,),
          Row(
            children: [
              NfsCheckBox(borderRadius: 10, checked: hasUppercase),
              SizedBox(width: 10,),
              Text('At least one upper case alphabet', style: defaultStyle,)
            ],
          ),
          SizedBox(height: 6,),
          Row(
            children: [
              NfsCheckBox(borderRadius: 10, checked: hasLowercase,),
              SizedBox(width: 10,),
              Text('At least one lower case alphabet', style: defaultStyle,)
            ],
          ),
          SizedBox(height: 6,),
          Row(
            children: [
              NfsCheckBox(borderRadius: 10, checked: hasSpecialCharacters,),
              SizedBox(width: 10,),
              Text('At least one special character', style: defaultStyle,)
            ],
          ),
          SizedBox(height: 6,),
          Row(
            children: [
              NfsCheckBox(borderRadius: 10, checked: hasDigits,),
              SizedBox(width: 10,),
              Text('At least one number', style: defaultStyle,)
            ],
          ),
        ],
      ),
    );
  }
}

class NfsCheckBox extends StatelessWidget {
  final bool checked;
  final double borderRadius;
  const NfsCheckBox({Key key, this.checked = false, this.borderRadius = 4}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: checked ? Constants.greenColor : Constants.primaryColor ,
        borderRadius: BorderRadius.circular(this.borderRadius),
        border: Border.all(color: checked ? Constants.greenColor : Constants.primaryColor, width: 2),
      ),
      child: checked ? Center(child: Icon(Icons.check, size: 8, color: Constants.whiteColor,)) : null,
    );
  }
}