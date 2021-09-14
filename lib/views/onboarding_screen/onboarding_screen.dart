import 'package:api_app/service/route_helpers.dart';
import 'package:api_app/views/home_screens/home_screen.dart';
import 'package:api_app/widget/custom_button/custom_button_widget.dart';
import 'package:api_app/widget/onboarding_widget/onboarding_item.dart';
import 'package:api_app/widget/onboarding_widget/page_indicator.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  static final routName = 'onBoarding';
  bool walk = true;

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  _onChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  List<Widget> _pages = [
    onBoardingWidget(
      title: "Easy Top Up",
      description: 'Add your phone credit or your friend here!',
      image: 'assets/images/onboard1.svg',
    ),
    onBoardingWidget(
      title: 'Easy Payment',
      description:
          'You don\'t need to go anywhere. Pay your monthly bills here!',
      image: 'assets/images/onboard2.svg',
    ),
    onBoardingWidget(
      title: 'Easy Shopping',
      description:
          'Buy everything at our Merchants ant you\'ll get a lot of benefits!',
      image: 'assets/images/onboard3.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // widget.walk =ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: _onChanged,
              itemBuilder: (context, int index) {
                return _pages[index];
              },
            ),
            Container(
              margin: EdgeInsetsDirectional.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < _pages.length; i++)
                          i == _currentPage
                              ? buildPageIndicator(true)
                              : buildPageIndicator(false),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: CustomButtonWidget(
                        onPressed: () {
                          setState(() {
                            if (_currentPage == 0) {
                              _pageController.animateToPage(1,
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.linear);
                            } else if (_currentPage == 1) {
                              _pageController.animateToPage(2,
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.linear);
                            } else {
                              RouteHelper.routeHelper.goToPageReplacement(
                                HomeScreen.routeName,
                              );
                            }
                          });
                        },
                        text: _currentPage == 2 ? 'Get Started' : 'Next'),

                    // MaterialButton(
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadiusDirectional.circular(25.r)),
                    //   splashColor: Colors.transparent,
                    //   highlightColor: Colors.transparent,
                    //   highlightElevation: 0,
                    //   color: ColorConst.primaryColor,
                    //   onPressed: () {
                    //
                    //   },
                    //   child: CustomText(
                    //     text: _currentPage == 2
                    //         ? easy.tr("onBoardingStartedButton")
                    //         : easy.tr("onBoardingNextButton"),
                    //     colorText: Colors.white,
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 20.sp,
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
