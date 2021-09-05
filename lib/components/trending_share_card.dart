import 'package:flutter/material.dart';
import 'package:invest_naija/business_logic/data/response/shares_response_model.dart';
import 'package:shimmer/shimmer.dart';

import '../constants.dart';

class TrendingShareCard extends StatelessWidget {
  final SharesResponseModel asset;

  const TrendingShareCard({Key key, this.asset}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 113,
        width: 150,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                asset.image,
                width: 30,
                height: 30,
              ),
              SizedBox(
                height: 14,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    this.asset.name,
                    style: TextStyle(
                        color: Constants.blackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(height: 5,),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'MTN',
              //       style: TextStyle(
              //         color: Constants.blackColor,
              //         fontSize: 10,),
              //     ),
              //     Container(
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           //Icon(Icons.arrow_drop_up_rounded, color: Constants.successColor,),
              //           // Text(
              //           //   '(19.25%)',
              //           //   style: TextStyle(
              //           //     color: Constants.successColor,
              //           //     fontSize: 10,),
              //           // ),
              //         ],
              //       ),
              //     )
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}


class LoadingTrendingShareCard extends StatelessWidget {

  const LoadingTrendingShareCard({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color.fromRGBO(151, 150, 145, 0.2),
      highlightColor: Color.fromRGBO(229, 229, 222, 0.6),
      child: Card(
        child: SizedBox(
          height: 113,
          width: 150,
        ),
      ),
    );
  }
}
