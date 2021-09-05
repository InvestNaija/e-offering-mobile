import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:invest_naija/constants.dart';

class PaymentWebScreen extends StatefulWidget {
  final String uri;
  final bool verifyAfterPayment;

  PaymentWebScreen(this.uri, {this.verifyAfterPayment = true})
      : assert(uri != null);

  createState() => _PaymentWebScreenState();
}

class _PaymentWebScreenState extends State<PaymentWebScreen> {
  String pleaseText = 'Loading...';

  String callbackUrl = '';
  String cancelCallbackUrl = '/cancel';
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if(url.contains('cancelled') || url.contains('success?status=successful')) {
        print('entered');
        Navigator.pop(context);
      }else{
        print('didnt enter');
      }
    });
  }

  @override
  void dispose() {
    flutterWebviewPlugin.close();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Constants.primaryColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(
              context,
            );
          },
          child: Container(
            width: 20,
            height: 40,
            child: Platform.isAndroid
                ? Icon(
              Icons.arrow_back,
              color: Colors.white,
            )
                : Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          "InvestNaija Online Payment",
          style: TextStyle(
              color: Colors.white,),
        ),
      ),
      url: widget.uri,
      hidden: true,
      initialChild: Dialog(elevation: 0.0, child: _buildDialogChild(context)),
    );
  }

  _buildDialogChild(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        elevation: 12,
        child: Container(
          padding: EdgeInsets.all(24.0),
          height: 100,
          child: Row(
            children: <Widget>[
              kCircularProgressIndicator(),
              SizedBox(
                width: 24.0,
              ),
              Expanded(
                child: Text(
                  pleaseText,
                  style: TextStyle(
                    //fontSize: singleTextUnit(context, 18.0),
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget kCircularProgressIndicator({
    Key key,
//  Android Values
    double value,
    Color backgroundColor,
    Animation<Color> valueColor,
    double strokeWidth = 4.0,

//  IOS values
    bool animating = true,
    double radius = 14,
  }) {
    return Platform.isAndroid
        ? CircularProgressIndicator(
      value: value,
      backgroundColor: backgroundColor,
      valueColor: valueColor,
      strokeWidth: strokeWidth,
    )
        : CupertinoActivityIndicator(
      animating: animating,
      radius: radius,
    );
  }
}
