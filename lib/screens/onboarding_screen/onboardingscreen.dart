import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invest_naija/components/custom_material_button.dart';
import 'package:invest_naija/constants.dart';
import 'package:invest_naija/screens/onboarding_screen/widget/pages.dart';
import 'package:invest_naija/screens/onboarding_screen/widget/pageview_dots_indicator.dart';

import '../enter_bvn_screen.dart';
import '../login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = '/onBoardingScreen';

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with SingleTickerProviderStateMixin {
  final _controller = PageController();
  AnimationController _animController;
  Animation<double> _animation;
  List<Widget> _pages;

  int page = 0;

  Map<String, String> _contentMap = {
    'Unlock the Stock Market':
        'Unrestricted access to express interest and buy Nigerian Stocks',
    'Financial Freedom':
        'Unrestricted access to express interest and buy Nigerian Stocks',
    'Account Protection':
        'Adipiscing elit. In urna turpis etiam lectus adipiscing ligula.',
    'Learning Made Easy':
        'Unrestricted access to express interest and buy Nigerian Stocks',
  };

  @override
  void initState() {
    super.initState();

    _pages = [
      Page1(),
      Page2(),
      Page3(),
      Page4(),
    ];

    _animController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> willPop() {
    exit(0);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    MediaQueryData mediaQuery;
    mediaQuery = MediaQuery.of(context);

    var shortestSide = mediaQuery.size.shortestSide;
// Determine if we should use mobile layout or not. The
// number 600 here is a common breakpoint for a typical
// 7-inch tablet.
    final bool useMobileLayout = shortestSide < 600;
    bool isDone = page == _pages.length - 1;

    return WillPopScope(
      onWillPop: willPop,
      child: Scaffold(
          backgroundColor: Constants.whiteColor,
          body: Stack(
            children: [
              Positioned.fill(
                child: PageView.builder(
                  itemCount: _pages.length,
                  controller: _controller,
                  itemBuilder: (context, index) {
                    return _pages[index % _pages.length];
                  },
                  onPageChanged: (int p) {
                    _animController.reset();
                    setState(() {
                      page = p;
                      _animController.forward();
                    });
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Image.asset('assets/images/logo_with_white_text.png'),
                  Spacer(
                    flex: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: FadeTransition(
                      opacity: _animation,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: _contentMap.keys.elementAt(page),
                          style: theme.textTheme.headline6.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Constants.whiteColor),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 18, 16, 24),
                    child: FadeTransition(
                      opacity: _animation,
                      child: Text(
                        _contentMap.values.elementAt(page),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.subtitle1.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Constants.whiteColor.withOpacity(0.5)),
                      ),
                    ),
                  ),
                  Center(
                    child: PageViewDotsIndicator(
                      color: Color(0xFFEFB42E),
                      itemCount: _pages.length,
                      controller: _controller,
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: CustomMaterialButton(
                        height: 50,
                        minWidth: 450,
                        title: 'Create an account',
                        onPressed: () => signUpPage(context)),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: CustomMaterialButton(
                        height: 50,
                        minWidth: 450,
                        color: Constants.whiteColor,
                        // textColor: InvestAppColors.ternaryText,
                        // title: isDone ? 'Get Started' : 'Next',
                        title: 'Login',
                        showIcon: false,
                        onPressed: () => loginPage(context)),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                ],
              )
            ],
          )),
    );
  }

  loginPage(context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  signUpPage(context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EnterBvnScreen()));
  }
}
