import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invest_naija/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebScreen extends StatefulWidget {
  final String uri;
  final bool verifyAfterPayment;

  PaymentWebScreen(this.uri, {this.verifyAfterPayment = true})
      : assert(uri != null);

  createState() => _PaymentWebScreenState();
}

class _PaymentWebScreenState extends State<PaymentWebScreen> {
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
            initialUrl: widget.uri,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (response) {
              setState(() {isLoading = false;});
            },
            onWebViewCreated: (WebViewController webViewController) {
              //_controller.complete(webViewController);
            },
            onProgress: (int progress) {},
            navigationDelegate: (NavigationRequest request) {
              if (request.url.contains('cancelled') || request.url.contains('success?status=successful')) {
                Navigator.pop(context);
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
