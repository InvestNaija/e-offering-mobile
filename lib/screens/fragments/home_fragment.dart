import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invest_naija/business_logic/data/response/shares_response_model.dart';
import 'package:invest_naija/business_logic/data/response/transaction_response_model.dart';
import 'package:invest_naija/business_logic/providers/bank_provider.dart';
import 'package:invest_naija/business_logic/providers/customer_provider.dart';
import 'package:invest_naija/business_logic/providers/transaction_provider.dart';
import 'package:invest_naija/business_logic/providers/assets_provider.dart';
import 'package:invest_naija/business_logic/providers/wallet_provider.dart';
import 'package:invest_naija/components/custom_clipping.dart';
import 'package:invest_naija/components/dashboard_detail_card.dart';
import 'package:invest_naija/components/no_transactions.dart';
import 'package:invest_naija/components/transaction_error.dart';
import 'package:invest_naija/components/transaction_row.dart';
import 'package:invest_naija/components/trending_share_card.dart';
import 'package:invest_naija/mixins/application_mixin.dart';
import 'package:invest_naija/utils/formatter_util.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

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
                          "Buy Offerings,",
                          style: TextStyle(
                              color: Constants.whiteColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 5,),
                        const Text(
                          "Unlock the stock market-Unrestricted access\nto buy Nigerian stocks",
                          style: TextStyle(
                              color: Constants.neutralColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 35,),
                        Consumer<TransactionProvider>(
                          builder: (context, transactionProvider, child) {
                            return DashboardDetailCard(walletBalance: transactionProvider.portfolioAmount);
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
              Consumer<AssetsProvider>(
                builder: (context, assetsProvider, child) {
                  return assetsProvider.hasError ? Container(
                    width: double.infinity,
                    color: Constants.whiteColor,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: [
                        Text(assetsProvider.errorMessage ?? 'An error occurred'),
                        Text('Please pull down to refresh!!'),
                      ],
                    ),
                  ) :
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(
                        height: 133,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: assetsProvider.isLoadingTrendingShares ? 5 : assetsProvider.trendingAssets?.length ?? 0,
                          itemBuilder: (context, index){
                            return assetsProvider.isLoadingTrendingShares ? LoadingTrendingShareCard() :
                            TrendingShareCard(
                              asset: assetsProvider.trendingAssets[index],
                              onTapped: (SharesResponseModel asset){
                                Navigator.pushNamed(context, '/ipo-detail', arguments: asset);
                              },
                            );
                          },
                  ),
                      ),
                    );
                },
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
                        return transactionsProvider.hasError ? TransactionError(message: transactionsProvider.errorMessage,) :
                          transactionsProvider.recentTransactions.length == 0 && !transactionsProvider.loadingRecentTransaction ?
                        NoTransactions() : Column(
                          children: List.generate(
                              transactionsProvider.loadingRecentTransaction ? 5 : transactionsProvider.recentTransactions.length,
                                  (index) => transactionsProvider.loadingRecentTransaction ?
                                  LoadingTransactionRow() :
                                  TransactionRow(
                                      transaction: transactionsProvider.recentTransactions[index],
                                      onTap: (){
                                        Navigator.pushNamed(context, '/transaction-summary', arguments: transactionsProvider.recentTransactions[index]);
                                      },
                                      onEdit:(TransactionResponseModel transaction){
                                        Navigator.pushNamed(context, '/update-interest', arguments: transaction);
                                      },
                                  )
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
