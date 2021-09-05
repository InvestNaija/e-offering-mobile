import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invest_naija/business_logic/providers/login_provider.dart';
import 'package:invest_naija/mixins/application_mixin.dart';
import 'package:invest_naija/screens/login_screen.dart';
import 'package:invest_naija/utils/formatter_util.dart';
import 'package:provider/provider.dart';

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
        padding: EdgeInsets.only(top: 76, bottom: 52),
        color: Constants.navyBlueColor,
        child: Column(
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
                      const Text(
                        'View profile',
                        style: const TextStyle(
                            color: Constants.whiteColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      )
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
            // ListTile(
            //   leading: SvgPicture.asset("assets/images/wallet.svg",
            //       width: 25, height: 25),
            //   title: const Text('My wallet',
            //       style: const TextStyle(
            //           color: Constants.whiteColor,
            //           fontSize: 15,
            //           fontWeight: FontWeight.w500)),
            //   onTap: ()=> changePage(context, 3),
            // ),
            ListTile(
              leading: SvgPicture.asset("assets/images/settings.svg",
                  width: 25, height: 25),
              title: const Text('Settings',
                  style: const TextStyle(
                      color: Constants.whiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
              onTap: ()=> changePage(context, 3),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 50, left: 20),
              child: Container(
                padding: EdgeInsets.only(right: 20, left: 20),
                decoration: BoxDecoration(
                    color: Constants.greenColor,
                    borderRadius: BorderRadius.circular(10)),
                height: 77,
                child: Row(
                  children: [
                    Transform.translate(
                        offset: Offset(0, -20),
                        child: SvgPicture.asset(
                          "assets/images/lady.svg",
                        )),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: const Text('Go to Learning Page',
                                  style: TextStyle(
                                      color: Constants.whiteColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800))),
                          const Text(
                              'Click here to see InvestNaija Learning Platform',
                              style: const TextStyle(color: Constants.whiteColor, fontSize: 10)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
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
          ],
        ),
      ),
    );
  }
}
