import 'package:flutter/material.dart';
import '../constants.dart';

class CustomIconButton extends StatelessWidget {
  final Function onTap;
  final IconData icon;

  const CustomIconButton({Key key, this.onTap, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency, //Makes it usable on any background color, thanks @IanSmith
        child: Ink(
          decoration: BoxDecoration(
            color: Constants.primaryColor,
            shape: BoxShape.circle,
          ),
          child: InkWell(
            //This keeps the splash effect within the circle
            borderRadius: BorderRadius.circular(1000.0), //Something large to ensure a circle
            onTap: ()=> this.onTap(),
            child: Padding(
              padding:EdgeInsets.all(20.0),
              child: Icon(
                this.icon,
                size: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        )
    );
  }
}
