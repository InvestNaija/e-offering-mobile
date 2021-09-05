import 'dart:async';

import 'package:flutter/material.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_clipping.dart';
import 'package:invest_naija/constants.dart';

import 'enter_bvn_screen.dart';
import 'enter_nin_screen.dart';
import 'login_screen.dart';

class WalkThroughScreen extends StatefulWidget {
  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  int _currentPage = 0;
  PageController _pageController = PageController();
  final List<String> titles = ["Unlock the Stock Market", "Financial Freedom", "Account Protection", "Learning Made Easy"];
  final List<String> detail = [
    "Unrestricted access to express\ninterest and buy Nigerian Stocks",
    "Unrestricted access to express\ninterest and buy Nigerian Stocks",
    "Unrestricted access to express\ninterest and buy Nigerian Stocks",
    "Unrestricted access to express\ninterest and buy Nigerian Stocks"
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      _currentPage = _pageController.page.toInt();
      setState(() {});
    });


    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if(!_pageController.hasClients) return;
      _currentPage < 3 ? _currentPage++ : _currentPage = 0;
      _pageController.animateToPage(_currentPage,
        duration: Duration(milliseconds: 1350), curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
         child: Column(
           children: [
             SizedBox(
                 height: 560,
                 child: PageView.builder(
                   controller: _pageController,
                   itemCount: 4,
                   itemBuilder: (BuildContext context, int index) {
                     return Column(
                       children: [
                         ClipPath(
                             clipper: CustomClipping(30),
                             child: Image.asset("assets/images/walkthrough-${index + 1}.png",)
                         ),
                         Spacer(),
                         Container(
                           child: Column(
                             children: [
                               Text(titles[index], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                               const SizedBox(height: 10,),
                               Text(
                                   detail[index],
                                   textAlign: TextAlign.center,
                                   style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Constants.fontColor2)
                               ),
                             ],
                           ),
                         ),
                       ],
                     );
                   },
                 )
             ),
             Padding(
               padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
               child: Column(
               children: [
                 new Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     AnimatedContainer(
                       width: 23,
                       height: 5.11,
                       duration: Duration(milliseconds: 200),
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: this._currentPage == 0 ? Constants.primaryColor : Constants.primaryColorA20),
                     ),
                     const SizedBox(width: 10,),
                     AnimatedContainer(
                       width: 23,
                       height: 5.11,
                       duration: Duration(milliseconds: 50),
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: this._currentPage == 1 || this._currentPage == null ? Constants.primaryColor : Constants.primaryColorA20),
                     ),
                     const SizedBox(width: 10,),
                     AnimatedContainer(
                       width: 23,
                       height: 5.11,
                       duration: Duration(milliseconds: 50),
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: this._currentPage == 2 || this._currentPage == null ? Constants.primaryColor : Constants.primaryColorA20),
                     ),
                     const SizedBox(width: 10,),
                     AnimatedContainer(
                       width: 23,
                       height: 5.11,
                       duration: Duration(milliseconds: 50),
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: this._currentPage == 3 || this._currentPage == null ? Constants.primaryColor : Constants.primaryColorA20),
                     ),
                   ],
                 ),
                 const SizedBox(height: 40,),
                 CustomButton(data: "Create an account",
                   textColor: Constants.whiteColor,
                   color: Constants.primaryColor,
                   onPressed: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => EnterBvnScreen()));
                   },),
                 const SizedBox(height: 17,),
                 CustomButton(data: "Login",textColor: Constants.blackColor, color: Constants.secondaryColor, onPressed: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                 },)
               ],
             ),)
           ],
         ),
        ),
      ),
    );
  }
}


