import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:invest_naija/business_logic/data/response/shares_response_model.dart';
import 'package:invest_naija/business_logic/providers/transaction_provider.dart';
import 'package:invest_naija/constants.dart';
import 'package:invest_naija/mixins/application_mixin.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebScreen extends StatefulWidget {
  final PaymentWebScreenArguments paymentWebScreenArguments;
  final bool verifyAfterPayment;

  PaymentWebScreen(this.paymentWebScreenArguments, {this.verifyAfterPayment = true})
      : assert(paymentWebScreenArguments != null);

  createState() => _PaymentWebScreenState();
}

class _PaymentWebScreenState extends State<PaymentWebScreen> with ApplicationMixin{
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.paymentWebScreenArguments.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (response) {
              setState(() {isLoading = false;});
            },
            onWebViewCreated: (WebViewController webViewController) {
              //_controller.complete(webViewController);
            },
            onProgress: (int progress) {},
            navigationDelegate: (NavigationRequest request) async{
              print(request.url);
              if (request.url.contains('cancelled')) {
                print('entered cancelled ----->');
                Navigator.pop(context, false);

              }else if(request.url.contains('success?status=successful')){
                final snackBar = SnackBar(content: Text('Payment successful, you will be redirected back'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

              }else if(request.url.contains('https://e-offering.netlify.com/dashboard/transactions')){
                print(request.url);
                print('entered success ----->');
                changePage(context, 2, shouldPop: false);
                await Future.delayed(Duration(seconds: 1));
                var asset = widget.paymentWebScreenArguments.asset;
                Provider.of<TransactionProvider>(context, listen: false).refreshTransactions();
                Navigator.pop(context, true);
              }
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {},
            gestureNavigationEnabled: true,
          ),
          Center(
            child: Offstage(
                offstage: !isLoading,
                child: CircularProgressIndicator(color: Constants.primaryColor,)),
          )
        ],
      ),
    );
  }
}

class PaymentWebScreenArguments {
  final String url;
  final SharesResponseModel asset;

  PaymentWebScreenArguments(this.url, this.asset);
}


