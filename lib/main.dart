import 'dart:async';
import 'package:flutter/material.dart';
import 'package:invest_naija/business_logic/providers/customer_provider.dart';
import 'package:invest_naija/business_logic/providers/payment_provider.dart';
import 'package:invest_naija/business_logic/providers/wallet_provider.dart';
import 'package:invest_naija/business_logic/repository/local/local_storage.dart';
import 'package:invest_naija/constants.dart';
import 'package:invest_naija/mixins/dialog_mixin.dart';
import 'package:invest_naija/screens/dashboard_screen.dart';
import 'package:invest_naija/screens/enter_bank_information_screen.dart';
import 'package:invest_naija/screens/expression_of_interest_screen.dart';
import 'package:invest_naija/screens/login_screen.dart';
import 'package:invest_naija/screens/splash_screen.dart';
import 'package:invest_naija/screens/walkthrough_screen.dart';
import 'package:provider/provider.dart';
import 'business_logic/data/response/shares_response_model.dart';
import 'business_logic/providers/bank_provider.dart';
import 'business_logic/providers/document_provider.dart';
import 'business_logic/providers/login_provider.dart';
import 'business_logic/providers/proof_of_address_document_provider.dart';
import 'business_logic/providers/proof_of_id_document_provider.dart';
import 'business_logic/providers/proof_of_signature_document_provider.dart';
import 'business_logic/providers/register_provider.dart';
import 'business_logic/providers/transaction_provider.dart';
import 'business_logic/providers/assets_provider.dart';
import 'screens/create_cscs_account_screen.dart';
import 'screens/enter_cscs_number.dart';
import 'screens/overall_container_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  appLocalStorage = await LocalStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => RegisterProvider()),
        ChangeNotifierProvider(create: (context) => CustomerProvider()),
        ChangeNotifierProvider(create: (context) => AssetsProvider()),
        ChangeNotifierProvider(create: (context) => WalletProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
        ChangeNotifierProvider(create: (context) => BankProvider()),
        ChangeNotifierProvider(create: (context) => DocumentProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
        ChangeNotifierProvider(create: (context) => ProofOfAddressDocumentProvider()),
        ChangeNotifierProvider(create: (context) => ProofOfIdDocumentProvider()),
        ChangeNotifierProvider(create: (context) => ProofOfSignatureDocumentProvider()),
      ],
      child: MyApp(),
    ),
  );
}




final navigatorKey = GlobalKey<NavigatorState>();
bool userIsInsideApp = false;

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with DialogMixins{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  OverallContainer(
      context: context,
      onTimeExpired: () {
        if (userIsInsideApp) {
          showInactivityAlert(this.context);
        }
        // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => LogoutScreen()));
      },
      child: MaterialApp(
        navigatorKey:navigatorKey,
        title: 'InvestNaija',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Constants.whiteColor,
          fontFamily: "HKGrotesk",
          primarySwatch: Constants.primaryColorMaterial,
        ),
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            return MaterialPageRoute(builder: (_) => SplashScreen());
          }
          if (settings.name == '/on-boarding') {
            return MaterialPageRoute(builder: (_) => WalkThroughScreen());
          }
          if (settings.name == '/login') {
            return MaterialPageRoute(builder: (_) => LoginScreen());
          }
          if (settings.name == '/dashboard') {
            return MaterialPageRoute(builder: (_) => DashboardScreen());
          }
          if (settings.name == '/enter-cscs') {
            bool navigateBack = settings.arguments as bool;
            return MaterialPageRoute(builder: (_) => EnterCscsNumber(navigateBack: navigateBack,));
          }
          if (settings.name == '/enter-bank-detail') {
            return MaterialPageRoute(builder: (_) => EnterBankInformationScreen());
          }
          if (settings.name == '/express-interest') {
            SharesResponseModel asset = settings.arguments as SharesResponseModel;
            return MaterialPageRoute(builder: (_) => ExpressionOfInterestScreen(asset: asset,));
          }
          if (settings.name == '/create-cscs') {
            return MaterialPageRoute(builder: (_) => CreateCscsAccountScreen());
          }
          return null; // Let `onUnknownRoute` handle this behavior.
        },
        initialRoute: '/',
      ),
    );
  }

  showInactivityAlert(BuildContext context) {
    showDialog(
      context: navigatorKey.currentState.overlay.context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: Dialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
            child: Container(
              height: 160,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Session Timeout",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Please log in again to continue",
                            textAlign: TextAlign.center,
                          ))),
                  RaisedButton(
                    onPressed: () async{
                      bool hasClearedCache = await Provider.of<LoginProvider>(context, listen: false).logout();
                      if(hasClearedCache){
                        Navigator.popUntil(context, ModalRoute.withName('/login'));
                      }
                    },
                    child: Text("OK"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}