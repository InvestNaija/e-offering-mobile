import 'package:flutter/material.dart';

import '../constants.dart';

class DashboardDetailCard extends StatefulWidget {
  final double walletBalance;

  const DashboardDetailCard({Key key, this.walletBalance}) : super(key: key);
  @override
  _DashboardDetailCardState createState() => _DashboardDetailCardState();
}

class _DashboardDetailCardState extends State<DashboardDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
            minHeight: 116,
            maxHeight: 116,
            minWidth: double.infinity),
        decoration: BoxDecoration(
          color: Constants.greenColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 10,
              left: 10,
              top: 30,
              child: Image.asset(
                "assets/images/hexagon.png",
                height: 77,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 24, top: 18, bottom: 18, right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 75,
                    child: PageView(
                      children: [
                        _walletBalance(balance: widget.walletBalance, name: 'Portfolio'),
                        //_walletBalance(balance: 0.00, name: 'InvestIN'),
                        //_walletBalance(balance: 0.00, name: 'TradeIN'),
                        //_walletBalance(balance: 0.00, name: 'SaveIN'),
                      ],
                    ),
                  ),
                  // const Spacer(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     AnimatedContainer(
                  //       width: 5,
                  //       height: 5,
                  //       duration: Duration(milliseconds: 200),
                  //       decoration: BoxDecoration(
                  //         borderRadius:
                  //         BorderRadius.circular(2.5),
                  //         color: Constants.whiteColor,
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     AnimatedContainer(
                  //       width: 5,
                  //       height: 5,
                  //       duration: Duration(milliseconds: 200),
                  //       decoration: BoxDecoration(
                  //         borderRadius:
                  //         BorderRadius.circular(2.5),
                  //         color: Constants.whiteColor,
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     AnimatedContainer(
                  //       width: 5,
                  //       height: 5,
                  //       duration: Duration(milliseconds: 200),
                  //       decoration: BoxDecoration(
                  //         borderRadius:
                  //         BorderRadius.circular(2.5),
                  //         color: Constants.whiteColor,
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     AnimatedContainer(
                  //       width: 5,
                  //       height: 5,
                  //       duration: Duration(milliseconds: 200),
                  //       decoration: BoxDecoration(
                  //         borderRadius:
                  //         BorderRadius.circular(2.5),
                  //         color: Constants.whiteColor,
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
            Positioned(
              bottom: 15,
              right: 15,
              child: Text(
                "Hide Balance",
                style: TextStyle(
                    color: Constants.gray6Color, fontSize: 12),
              ),
            ),
          ],
        ));
  }

  Widget _walletBalance({double balance, String name}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name ?? "Wallet Balance",
          style: TextStyle(
              color: Constants.whiteColor,
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "₦$balance",
          style: TextStyle(
              fontFamily: 'Roboto',
              color: Constants.whiteColor,
              fontSize: 28,
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
