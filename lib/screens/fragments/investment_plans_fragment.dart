import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invest_naija/business_logic/data/response/shares_response_model.dart';
import 'package:invest_naija/business_logic/providers/assets_provider.dart';
import 'package:invest_naija/components/custom_lead_icon.dart';
import 'package:invest_naija/components/investment_product_card.dart';
import 'package:invest_naija/constants.dart';
import '../e-ipo_details_screen.dart';
import 'package:provider/provider.dart';

class InvestmentPlansFragment extends StatefulWidget {
  @override
  _InvestmentPlansFragmentState createState() => _InvestmentPlansFragmentState();
}

class _InvestmentPlansFragmentState extends State<InvestmentPlansFragment> {

  @override
  void initState() {
    Provider.of<AssetsProvider>(context, listen: false).getEIpoAssets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30,),
          const Text("Offerings", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Constants.blackColor),),
          const SizedBox(height: 5,),
          const Text(
            "Choose from any of our offerings to maximize your earnings and secure your future",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Constants.neutralColor),),
          const SizedBox(height: 30,),
          Row(
            children: [
              SvgPicture.asset("assets/images/explore.svg"),
              const SizedBox(width: 10,),
              const Text("Explore Offerings", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Constants.blackColor),),
            ],
          ),
          const SizedBox(height: 10,),
          Consumer<AssetsProvider>(
            builder: (context, assetsProvider, child) {
              return Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 4.0,
                      maxCrossAxisExtent: 200,
                    ),
                    itemCount: assetsProvider.isLoadingEIpoAssets ? 5 : assetsProvider.eIpoAssets.length,
                    itemBuilder: (context, index) {
                      return assetsProvider.isLoadingEIpoAssets? LoadingInvestmentProductCard() :
                      InvestmentProductCard(
                        asset: assetsProvider.eIpoAssets[index],
                        onTap: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => EIpoDetailsScreen(asset: assetsProvider.eIpoAssets[index],)));
                        },
                      );
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
