import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invest_naija/business_logic/data/response/transaction_response_model.dart';
import 'package:invest_naija/business_logic/providers/bank_provider.dart';
import 'package:invest_naija/business_logic/providers/customer_provider.dart';
import 'package:invest_naija/business_logic/providers/transaction_provider.dart';
import 'package:invest_naija/business_logic/providers/assets_provider.dart';
import 'package:invest_naija/business_logic/providers/wallet_provider.dart';
import 'package:invest_naija/components/custom_clipping.dart';
import 'package:invest_naija/components/dashboard_detail_card.dart';
import 'package:invest_naija/components/no_transactions.dart';
import 'package:invest_naija/components/option_card.dart';
import 'package:invest_naija/components/transaction_row.dart';
import 'package:invest_naija/components/trending_share_card.dart';
import 'package:invest_naija/mixins/application_mixin.dart';
import 'package:invest_naija/utils/formatter_util.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../transaction_summary_screen.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> with ApplicationMixin{

  AssetsProvider _assetsProvider;
  BankProvider _bankProvider;
  TransactionProvider _transactionProvider;
  WalletProvider _walletProvider;
  CustomerProvider _customerProvider;

  @override
  void initState() {
    super.initState();
    _assetsProvider =  Provider.of<AssetsProvider>(context, listen: false);
    _bankProvider = Provider.of<BankProvider>(context, listen: false);
    _transactionProvider = Provider.of<TransactionProvider>(context, listen: false);
    _walletProvider = Provider.of<WalletProvider>(context, listen: false);
    _customerProvider = Provider.of<CustomerProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) => updateHomeScreen());
  }

  Future<bool> updateHomeScreen({bool isRefresh = false}) async{
    _customerProvider.getCustomerFromLocalStorage();
    _bankProvider.getListOfBanks();
    _bankProvider.getBankDetailsFromSharedPreference();
    _walletProvider.getWalletBalance();
    if(isRefresh){
      _assetsProvider.refreshPopularAssets();
      _transactionProvider.refreshRecentTransactions();
    }else{
      _assetsProvider.getPopularAssets();
      _transactionProvider.getRecentTransactions();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return updateHomeScreen(isRefresh: true);
      },
      child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: CustomClipping(70),
                    child: Container(height: 255, color: Constants.navyBlueColor,),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer<CustomerProvider>(
                          builder: (context, customer, child) {
                            return Text(
                              'Hello ${FormatterUtil.formatName(customer.user.firstName != null ? customer.user.firstName.toLowerCase() : '')},',
                              style: TextStyle(
                                  color: Constants.whiteColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800),
                            );
                          },
                        ),
                        const SizedBox(height: 23,),
                        const Text(
                          "Buy Shares,",
                          style: TextStyle(
                              color: Constants.whiteColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 5,),
                        const Text(
                          "Express interests in hundreds of Nigerian and\nInternational Stocks, and be notified when they\nare available for purchase. ",
                          style: TextStyle(
                              color: Constants.neutralColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 35,),
                        Consumer<WalletProvider>(
                          builder: (context, walletProvider, child) {
                            return DashboardDetailCard(walletBalance: walletProvider.walletBalance?.toDouble() ?? 0.0,);
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 30,
                    child: SvgPicture.asset(
                      "assets/images/lady-left.svg",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25,),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 22),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           OptionCard(
              //             title: "Go to Investments",
              //             imageAssetUrl: "assets/images/graph.svg",
              //             onTap: () => Provider.of<CustomerProvider>(context, listen: false).changePage(1),
              //           ),
              //           OptionCard(
              //             title: "Check Wallet",
              //             imageAssetUrl: "assets/images/briefcase.svg",
              //             onTap: () => Provider.of<CustomerProvider>(context, listen: false).changePage(3),
              //           ),
              //         ],
              //       ),
              //       const SizedBox(height: 25,),
              //       const Text('Trending Shares',
              //         style: TextStyle(
              //             color: Constants.blackColor,
              //             fontSize: 15,
              //             fontWeight: FontWeight.bold),
              //       ),
              //       const SizedBox(height: 12,),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  height: 133,
                  child: Consumer<AssetsProvider>(
                    builder: (context, trendingShares, child) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: trendingShares.isLoadingTrendingShares ? 5 : trendingShares.trendingAssets?.length ?? 0,
                          itemBuilder: (context, index){
                            return trendingShares.isLoadingTrendingShares ? LoadingTrendingShareCard() :
                            TrendingShareCard(asset: trendingShares.trendingAssets[index],);
                          });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Recent transactions',
                      style: const TextStyle(
                          color: Constants.blackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () => Provider.of<CustomerProvider>(context, listen: false).changePage(2),
                        child: Row(
                          children: [
                            const Text('View all',
                              style: const TextStyle(
                                  color: Constants.primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 9,),
                            Icon(Icons.arrow_forward_ios, size: 13, color: Constants.primaryColor,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Consumer<TransactionProvider>(
                      builder: (context, transactionsProvider, child) {
                        return transactionsProvider.recentTransactions.length == 0 && !transactionsProvider.loadingRecentTransaction ?
                        NoTransactions() : Column(
                          children: List.generate(
                              transactionsProvider.loadingRecentTransaction ? 5 : transactionsProvider.recentTransactions.length,
                                  (index) => transactionsProvider.loadingRecentTransaction ? LoadingTransactionRow() : TransactionRow(
                                      transaction: transactionsProvider.recentTransactions[index],
                                      onTap: (){
                                        Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => TransactionSummaryScreen(
                                          transaction: transactionsProvider.recentTransactions[index],
                                        )));
                                  })
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
