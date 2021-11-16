import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invest_naija/business_logic/providers/login_provider.dart';
import 'package:invest_naija/mixins/application_mixin.dart';
import 'package:invest_naija/utils/formatter_util.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class CustomDrawer extends StatelessWidget with ApplicationMixin{
  final String firstName;
  final String lastName;
  final String image;

  const CustomDrawer({Key key, this.firstName, this.lastName, this.image = ""}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Constants.navyBlueColor,
        padding: EdgeInsets.only(top: 50),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundImage: NetworkImage(
                        this.image == null || this.image == "" ? 'https://i.ibb.co/9hgQFDx/user.png' : this.image),
                  ),
                  const SizedBox(width: 17,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( '${FormatterUtil.formatName('${this.firstName} ${this.lastName}')}',
                        style: TextStyle(
                            color: Constants.whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30,),
            ListTile(
              leading: SvgPicture.asset("assets/images/dashboard.svg",
                  width: 25, height: 25),
              title: const Text('Dashboard',
                  style: const TextStyle(
                      color: Constants.whiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
              onTap: () => changePage(context, 0),
            ),
            ListTile(
              leading: SvgPicture.asset("assets/images/chart.svg",
                  width: 25, height: 25),
              title: const Text('Offerings',
                  style: const TextStyle(
                      color: Constants.whiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
              onTap: ()=> changePage(context, 1),
            ),
            ListTile(
              leading: SvgPicture.asset("assets/images/graph.svg",
                  width: 25, height: 25),
              title: const Text('Transactions',
                  style: const TextStyle(
                      color: Constants.whiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
              onTap: ()=> changePage(context, 2),
            ),
            ListTile(
              leading: SvgPicture.asset("assets/images/wallet.svg",
                  width: 25, height: 25),
              title: const Text('FAQ',
                  style: const TextStyle(
                      color: Constants.whiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
              onTap: ()=> changePage(context, 3),
            ),
            ListTile(
              leading: SvgPicture.asset("assets/images/settings.svg",
                  width: 25, height: 25),
              title: const Text('Settings',
                  style: const TextStyle(
                      color: Constants.whiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
              onTap: ()=> changePage(context, 4),
            ),
            ListTile(
              leading: SvgPicture.asset("assets/images/logout.svg", width: 25, height: 25),
              title: Text('Logout', style: TextStyle(color: Constants.whiteColor, fontSize: 15,)),
              onTap: () async{
                bool hasClearedCache = await Provider.of<LoginProvider>(context, listen: false).logout();
                if(hasClearedCache){
                  changePage(context,0);
                  Navigator.pushNamed(context, '/login');
                }
              },
            ),
            SizedBox(height: 40,),
            Padding(
              padding: EdgeInsets.only(right: 50, left: 20),
              child: Container(
                padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: Constants.greenColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Need Help?', style: TextStyle(color: Constants.whiteColor),),
                    SizedBox(height: 5,),
                    GestureDetector(
                        onTap: (){
                          print('this is it');
                          final Uri emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: 'info@primaryofferng.com',
                            query: encodeQueryParameters(<String, String>{
                              'subject': ''
                            }),
                          );
                          launch(emailLaunchUri.toString());
                        },
                        child: Text('Email us at \ninfo@primaryofferng.com', style: TextStyle(color: Constants.navyBlueColor),)
                    ),
                    SizedBox(height: 5,),
                    RichText(text: TextSpan(
                        text: 'or call ' ,
                        children: [
                           TextSpan(text: '070046837862452'),
                          // TextSpan(text: '(070046837862452)\n', style: TextStyle(fontSize: 12)),
                          // TextSpan(text: '\n'),
                          // TextSpan(text: 'OR\n'),
                          // TextSpan(text: '\n'),
                          // TextSpan(text: '0700-CHAPELHILL\n'),
                          // TextSpan(text: '(07002427354455)', style: TextStyle(fontSize: 12)),
                        ]
                    ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  String encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
