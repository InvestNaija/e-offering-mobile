import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invest_naija/business_logic/data/response/customer_response_model.dart';
import 'package:invest_naija/business_logic/providers/customer_provider.dart';
import 'package:invest_naija/business_logic/providers/login_provider.dart';
import 'package:invest_naija/components/custom_drawer.dart';
import 'package:invest_naija/constants.dart';
import 'package:invest_naija/mixins/application_mixin.dart';
import 'package:invest_naija/mixins/dialog_mixin.dart';
import 'package:invest_naija/screens/fragments/account_setting_fragment.dart';
import 'package:invest_naija/screens/fragments/home_fragment.dart';
import 'package:invest_naija/screens/fragments/transactions_fragment.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'fragments/investment_fragment.dart';
import 'fragments/investment_plans_fragment.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with DialogMixins, ApplicationMixin {

  CustomerResponseModel user;
  @override
  void initState() {
    super.initState();
    userIsInsideApp = true;
    //WidgetsBinding.instance.addPostFrameCallback((_)=> changePage(context,0));
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerProvider>(
      builder: (context, customerProvider, child) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: Constants.dashboardBackgroundColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: customerProvider.currentPage == 0 ? Constants.navyBlueColor : Constants.dashboardBackgroundColor,
              leading: Builder(
                builder: (context) => GestureDetector(
                  child: Transform(
                    transform: Matrix4.identity()..scale(0.45)..translate(50.0, 40.0, 0.0),
                    child: Image.asset(
                      'assets/images/drawer_icon.png',
                      color: customerProvider.currentPage == 0 ? Constants.whiteColor : Constants.blackColor,
                      height: 16,
                    ),
                  ),
                  onTap: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              actions: customerProvider.currentPage == 0 ? [
              SvgPicture.asset("assets/images/notification.svg", width: 43, height: 43),
              ] : [],
            ),
            drawer: CustomDrawer(
              firstName: customerProvider?.user?.firstName ?? '',
              lastName: customerProvider?.user?.lastName ?? '',
              image: customerProvider?.user?.image,
            ),
            body: IndexedStack(
              index: customerProvider.currentPage,
              children: [
                HomeFragment(),
                InvestmentPlansFragment(),
                TransactionsFragment(),
                AccountSettingFragment()
              ],
            ),
          ),
        );
      },
    );
  }
}
