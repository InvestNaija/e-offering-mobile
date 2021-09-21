import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invest_naija/business_logic/repository/local/local_storage.dart';

import '../constants.dart';

class DashboardDetailCard extends StatefulWidget {
  final Map<String, double> walletBalance;

  const DashboardDetailCard({Key key, this.walletBalance}) : super(key: key);
  @override
  _DashboardDetailCardState createState() => _DashboardDetailCardState();
}

class _DashboardDetailCardState extends State<DashboardDetailCard> {

  bool shouldHideBalance;

  @override
  void initState() {
    super.initState();
    shouldHideBalance = appLocalStorage.getHideBalance();
  }

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
                        _walletBalance(balance: widget.walletBalance['NGN'] ?? 0.0, name: 'Portfolio (NGN)', currency: 'NGN'),
                        _walletBalance(balance: widget.walletBalance['USD'] ?? 0.0, name: 'Portfolio (USD)', currency: 'USD'),
                        _walletBalance(balance: widget.walletBalance['EUR'] ?? 0.0, name: 'Portfolio (EUR)', currency: 'EUR'),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        width: 5,
                        height: 5,
                        duration: Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(2.5),
                          color: Constants.whiteColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      AnimatedContainer(
                        width: 5,
                        height: 5,
                        duration: Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(2.5),
                          color: Constants.whiteColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      AnimatedContainer(
                        width: 5,
                        height: 5,
                        duration: Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(2.5),
                          color: Constants.whiteColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 15,
              right: 15,
              child: GestureDetector(
                onTap: (){
                  appLocalStorage.setHideBalance(!shouldHideBalance);
                  shouldHideBalance = !shouldHideBalance;
                  setState(() {});
                },
                child: Text(
                  "Hide Balance",
                  style: TextStyle(
                      color: Constants.gray6Color, fontSize: 12),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _walletBalance({String currency, double balance, String name}){
    final formatCurrency = NumberFormat.simpleCurrency(locale: Platform.localeName, name: currency);
    String amount = formatCurrency.format(balance);
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
          shouldHideBalance ? '***' : amount,
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
