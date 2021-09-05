import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class OptionCard extends StatelessWidget {
  final String title;
  final String imageAssetUrl;
  final Function onTap;

  const OptionCard({Key key, this.title, this.imageAssetUrl, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: ()=> this.onTap(),
      child: Container(
          constraints: BoxConstraints(minHeight: 85, maxHeight: 85, minWidth: 150, maxWidth: 150),
          decoration: BoxDecoration(
            gradient:LinearGradient(
                colors: [
                  Constants.navyBlueColor,
                  Constants.tealColor
                ],
                begin: Alignment.topCenter, //begin of the gradient color
                end: Alignment.bottomCenter, //end of the gradient color
                stops: [0.1, 0.8] //stops for individual color
              //set the stops number equal to numbers of color
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Positioned(
                top:12,
                right: 10,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Constants.whiteColorA2
                  ),
                  constraints: BoxConstraints(minHeight: 28, maxHeight: 28, minWidth: 28, maxWidth: 28),
                  child: SvgPicture.asset(this.imageAssetUrl, height: 14, width: 14,
                  ),
                ),
              ),
              Positioned(
                bottom:14,
                left: 16,
                child: Text(this.title, style: TextStyle(color: Constants.gray6Color, fontSize: 12, fontWeight: FontWeight.w600),),
              ),
            ],
          )
      ),
    );
  }
}
