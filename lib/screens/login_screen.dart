import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:invest_naija/business_logic/data/response/login_response_model.dart';
import 'package:invest_naija/business_logic/providers/customer_provider.dart';
import 'package:invest_naija/business_logic/providers/login_provider.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_lead_icon.dart';
import 'package:invest_naija/components/custom_password_field.dart';
import 'package:invest_naija/components/custom_textfield.dart';
import 'package:invest_naija/mixins/dialog_mixin.dart';
import 'package:invest_naija/screens/forgot_password_screen.dart';
import 'package:invest_naija/utils/formatter_util.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';
import 'enter_bvn_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with DialogMixins, TickerProviderStateMixin  {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController;
  TextEditingController passwordController;
  FocusNode passwordFocusNode;
  FocusNode emailFocusNode;
  FocusNode loginButtonFocusNode;

  GifController controller;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    loginButtonFocusNode = FocusNode();
    controller = GifController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true, max: 18, min: 0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 31, top: 60),
                child: CustomLeadIcon(),
              ),
              SizedBox(height: 30,),
              // Container(
              //     alignment: Alignment.center,
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 16,
              //     ),
              //     child: Image.asset('assets/images/primary-bid-image.png')
              // ),
              SizedBox(height: 30,),
              // Container(
              //     alignment: Alignment.center,
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 16,
              //     ),
              //     child: GifImage(
              //       controller: controller,
              //       image: AssetImage('assets/images/logo_animated.gif',
              //       ),
              //       height: 160,
              //     )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 31),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Consumer<CustomerProvider>(
                      //     builder: (context, customerProvider, child) {
                      //       return  Text(
                      //           customerProvider.user != null && customerProvider.user.firstName != null?
                      //           "Welcome back ${FormatterUtil.formatName(customerProvider.user.firstName.toLowerCase())}!" : "Welcome to InvestNaija",
                      //           textAlign: TextAlign.center,
                      //           style: const TextStyle(
                      //               fontSize: 12,
                      //               fontWeight: FontWeight.w600,
                      //               color: Constants.fontColor2));
                      //     },
                      //   ),
                      // ),
                      const SizedBox(height: 3,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Login to your account",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Constants.blackColor)),
                      ),
                      const SizedBox(height: 44,),
                      CustomTextField(
                        label: "Email",
                        controller: emailController,
                        focusNode: emailFocusNode,
                        keyboardType: TextInputType.text,
                        regexPattern: r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$",
                        regexHint: 'Enter a valid email address',
                        onEditingComplete: (){
                          FocusScope.of(context).requestFocus(passwordFocusNode);
                          //emailFocusNode.requestFocus();
                        },
                      ),
                      const SizedBox(height: 25,),
                      CustomPasswordField(
                        label: "Password",
                        controller: passwordController,
                        onEditingComplete: (){
                          print('this is it');
                          FocusScope.of(context).requestFocus(loginButtonFocusNode);
                        },
                        focusNode: passwordFocusNode,
                      ),
                      const SizedBox(height: 25,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen())),
                          child: Text("Forgot Password?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Constants.errorAlertColor)),
                        ),
                      ),
                      const SizedBox(height: 32,),
                      Consumer<LoginProvider>(
                        builder: (context, loginProvider, child) {
                          return  CustomButton(
                            data: "Login to your account",
                            focusNode: loginButtonFocusNode,
                            isLoading: loginProvider.isLoading,
                            textColor: Constants.whiteColor,
                            color: Constants.primaryColor,
                            onPressed: () async{
                              if(!_formKey.currentState.validate()) return;
                              LoginResponseModel loginResponse = await Provider.of<LoginProvider>(context, listen: false).login(
                                  email : emailController.text.trim(),
                                  password: passwordController.text.trim()
                              );
                              if(loginResponse.error == null){
                                Navigator.of(context).pushNamed('/dashboard');

                              }else if(loginResponse.code == 411 || loginResponse.error.message.toLowerCase().contains('please verify your account to proceed.')){
                                Navigator.of(context).pushNamed('/otp', arguments: emailController.text.trim());

                              }else{
                                showSimpleModalDialog(context: context, title: 'Login Error', message: loginResponse.error.message);
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 27,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don???t have an account yet?",
                            style: TextStyle(
                                color: Constants.fontColor2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(width: 5,),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => EnterBvnScreen()));
                            },
                            child: const Text(
                              "Create one",
                              style: TextStyle(
                                  color: Constants.primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Need Help?',),
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
                                child: Text('Email us at info@primaryofferng.com',)
                            ),
                            SizedBox(height: 5,),
                            GestureDetector(
                              onTap: () async{
                                const url = "tel:070046837862452";
                                await launch(url);
                              },
                                child: Text('or call 070046837862452',)),
                          ],
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Text("Powered by", style: TextStyle(fontWeight: FontWeight.w600),),
            Image.asset('assets/images/ngx-logo.png', width: 100, height: 100,),
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

  void clearTextFields(){
    emailController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
