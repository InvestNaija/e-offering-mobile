import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class TransactionError extends StatelessWidget {
  final String message;
  const TransactionError({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/data-analyst.svg", height: 67, width: 88,),
          const SizedBox(height: 30,),
          Text(message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Constants.blackColor, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10,),
          const Text(
            'Please pull down to refresh.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Constants.neutralColor,),
          ),
        ],
      ),
    );
  }
}
