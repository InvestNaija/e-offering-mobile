import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class NoTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/data-analyst.svg", height: 67, width: 88,),
          const SizedBox(height: 30,),
          const Text(
            "Nothing to see here",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Constants.blackColor, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10,),
          const Text(
            "Your most recent transactions will show\nhere when you start transacting",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Constants.neutralColor,),
          ),
        ],
      ),
    );
  }
}
