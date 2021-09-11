import 'package:flutter/material.dart';
import 'package:invest_naija/business_logic/data/response/login_response_model.dart';
import 'package:invest_naija/business_logic/providers/customer_provider.dart';
import 'package:invest_naija/business_logic/providers/login_provider.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_password_field.dart';
import 'package:invest_naija/components/custom_textfield.dart';
import 'package:invest_naija/mixins/dialog_mixin.dart';
import 'package:invest_naija/screens/forgot_password_screen.dart';
import 'package:invest_naija/screens/otp_screen.dart';
import 'package:invest_naija/utils/formatter_util.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'enter_bvn_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with DialogMixins {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController;
  TextEditingController passwordController;
  FocusNode passwordFocusNode;
  FocusNode emailFocusNode;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordFocusNode = FocusNode();
    emailFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return Future.value(false);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 31, vertical: 32),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 60,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Consumer<CustomerProvider>(
                      builder: (context, customerProvider, child) {
                        return  Text(
                            customerProvider.user != null && customerProvider.user.firstName != null?
                            "Welcome back ${FormatterUtil.formatName(customerProvider.user.firstName.toLowerCase())}!" : "Welcome to InvestNaija",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Constants.fontColor2));
                      },
                    ),
                  ),
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
                    keyboardType: TextInputType.emailAddress,
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
                    onEditingComplete: (){},
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
                        isLoading: loginProvider.isLoading,
                        textColor: Constants.whiteColor,
                        color: Constants.primaryColor,
                        onPressed: () async{
                          if(!_formKey.currentState.validate()) return;
                          LoginResponseModel loginResponse = await Provider.of<LoginProvider>(context, listen: false).login(
                              email : emailController.text,
                              password: passwordController.text
                          );
                          if(loginResponse.error == null){
                            clearTextFields();
                            Navigator.of(context).pushNamed('/dashboard');
                          }else if(loginResponse.code == 411 || loginResponse.error.message.toLowerCase().contains('please verify your account to proceed.')){
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => OtpScreen(
                                  email: emailController.text,
                                )));
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
                        "Don’t have an account yet?",
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
                          "Sign up",
                          style: TextStyle(
                              color: Constants.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void clearTextFields(){
    emailController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
