// /*
// *  LoginPage
// *
// *  Created by [Folarin Opeyemi].
// *  Copyright © 2021 [Intelligent Innovations]. All rights reserved.
//     */
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_gifimage/flutter_gifimage.dart';
// import 'package:invest_naija/components/custom_material_button.dart';
// import 'package:invest_naija/constants.dart';
//
// class LoginPage extends StatelessWidget {
//   static const String routeName = '/loginPage';
//
//   Future<bool> _willPop() {
//     return Future.value(false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ThemeData theme = Theme.of(context);
//     final bool isDark = theme.brightness == Brightness.dark;
//
//     return WillPopScope(
//       onWillPop: _willPop,
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         extendBodyBehindAppBar: false,
//         backgroundColor: Color(0xFF002B43),
//         body: SingleChildScrollView(
//           child: LoginScreen(),
//         ),
//       ),
//     );
//   }
// }
//
// class LoginScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => LoginScreenState();
// }
//
// class LoginScreenState extends State<LoginScreen>
//     with
//        TickerProviderStateMixin {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   bool rememberMe = false;
//
//   String name = '';
//
//   GifController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = GifController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     )..repeat(reverse: true, max: 18, min: 0);
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       init();
//     });
//   }
//
//   init() async {}
//
//   @override
//   void dispose() {
//     emailController?.dispose();
//     passwordController?.dispose();
//     controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ThemeData theme = Theme.of(context);
//     return Form(
//       key: _formKey,
//       child: Stack(
//         children: <Widget>[
//           Container(
//             decoration: BoxDecoration(
//               color: Constants.whiteColor,
//             ),
//             child: Column(
//               children: [
//                 SafeArea(
//                   child: SizedBox(
//                     height: 34,
//                   ),
//                 ),
//                 Container(
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                     ),
//                     child: GifImage(
//                       controller: controller,
//                       image: AssetImage('assets/images/logo_animated.gif',
//                       ),
//                       height: 160,
//                     )),
//                 SizedBox(
//                   height: 100,
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(
//               top: 228,
//             ),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(35),
//                     topLeft: Radius.circular(35)),
//                 color: Color(0xFF002B43)),
//             child: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(35),
//                       topLeft: Radius.circular(35)),
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     stops: [
//                       0,
//                       0.75,
//                     ],
//                     colors: [
//                       Color(0xFF002B43).withOpacity(0.85),
//                       Color(0xFF002B43),
//                     ],
//                   ),
//                   color: Color(0xFF002B43)),
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 16,
//               ),
//               child: Container(
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 34,
//                       ),
//                       if (name != null && name.isNotEmpty)
//                         Text(
//                           'Welcome back $name!',
//                           style: theme.textTheme.subtitle2
//                               .copyWith(color: InvestAppColors.white),
//                         ),
//                       Text(
//                         'Login to continue',
//                         style: theme.textTheme.headline5.copyWith(
//                             fontWeight: kBoldWeight,
//                             color: InvestAppColors.white),
//                       ),
//                       SizedBox(
//                         height: 34,
//                       ),
//                       StreamBuilder(
//                           stream: loginValidatorBloc.emailOnly,
//                           builder: (context, snapshot) {
//                             return EditTextSignUp(
//                               hintText: '',
//                               validatorCallback:
//                                   formValidatorBloc.emailValidator,
//                               onChangedCallback:
//                                   loginValidatorBloc.changeEmailOnly,
//                               errorText: snapshot.error,
//                               textInputType: TextInputType.emailAddress,
//                               controller: emailController,
//                               labelText: 'Email Address',
//                             );
//                           }),
//                       SizedBox(
//                         height: 34,
//                       ),
//                       StreamBuilder(
//                           stream: loginValidatorBloc.password,
//                           builder: (context, snapshot) {
//                             return PasswordSignUp(
//                               hintText: 'Enter your password',
//                               validatorCallback:
//                                   formValidatorBloc.passwordValidator,
//                               onChangedCallback:
//                                   loginValidatorBloc.changePassword,
//                               errorText: snapshot.error,
//                               textInputType: TextInputType.text,
//                               controller: passwordController,
//                               labelText: 'Password',
//                               suffix: true,
//                             );
//                           }),
//                       SizedBox(
//                         height: 24,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           FutureBuilder<AppSettings>(
//                               future: appSettingsBloc.fetchAppSettings(),
//                               builder: (context, snapshot) {
//                                 if (snapshot.hasData) {
//                                   rememberMe = snapshot.data.rememberMe;
//
//                                   return CustomCheckBox(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       onChanged: (bool _value) {
//                                         rememberMe = _value;
//                                       },
//                                       name: 'Remember me',
//                                       initialValue: rememberMe);
//                                 }
//                                 return Container();
//                               }),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             ForgotPasswordPage(),
//                                         settings: RouteSettings(
//                                             name:
//                                                 ForgotPasswordPage.routeName)));
//                               },
//                               child: Text(
//                                 'Forgot Password?',
//                                 textAlign: TextAlign.right,
//                                 style: theme.textTheme.subtitle2.copyWith(
//                                   fontWeight: kSemiBoldWeight,
//                                   color: InvestAppColors.primaryButton,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 44,
//                       ),
//                       CustomMaterialButton(
//                           title: 'Login',
//                           textColor: Colors.white,
//                           onPressed: () => submit()),
//                       SizedBox(
//                         height: safeAreaHeight(context, 8),
//                       ),
//                       SizedBox(
//                         height: 24,
//                       ),
//                       Center(
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.popUntil(context,
//                                 ModalRoute.withName(SplashPage.routeName));
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => SignUpPage1(),
//                                     settings: RouteSettings(
//                                         name: SignUpPage1.routeName)));
//                           },
//                           child: RichText(
//                             text: TextSpan(
//                                 text: 'Don’t have an account yet? ',
//                                 style: theme.textTheme.bodyText1.copyWith(
//                                     fontWeight: kMediumWeight,
//                                     color: InvestAppColors.ternaryText),
//                                 children: [
//                                   TextSpan(
//                                     text: 'Sign up',
//                                     style: theme.textTheme.bodyText1.copyWith(
//                                         color: InvestAppColors.primaryButton,
//                                         fontWeight: kBoldWeight),
//                                   )
//                                 ]),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 54,
//                       ),
//                     ]),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   submit() async {
//     if (_formKey.currentState.validate()) {
//       LoginRequest loginRequest = LoginRequest(
//           email: emailController.text.trim(),
//           password: passwordController.text);
//       doLoginOperation(context, loginRequest, true, rememberMe,
//           (AuthResponse authResponse) {
//         passwordController.text = '';
//       });
//     }
//   }
// }
