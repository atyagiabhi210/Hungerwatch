import 'package:flutter/material.dart';
import 'package:hungerwatch/features/authentication/ui/auth.dart';
import 'package:hungerwatch/features/onboarding/ui/pages/OnboardingPage1.dart';
import 'package:hungerwatch/features/onboarding/ui/pages/onbaordingPage2.dart';
import 'package:hungerwatch/features/onboarding/ui/pages/onboardingPage3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() {
    return _OnboardingScreenState();
  }
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // to control the page we are on
  bool isLast = false;
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            if (index == 2) {
              setState(() {
                isLast = true;
              });
            } else {
              setState(() {
                isLast = false;
              });
            }
          },
          children: [
            OnboardingPage1(),
            // Container(color: Colors.red,),
            OnboardingPage2(),
            //Container(color: Colors.green,),

            OnboardingPage3(), // Container(color: Colors.blue,),
          ],
        ),
        //Dot indicators
        Container(
            alignment: const Alignment(0, 0.85),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Skip button
                  TextButton(
                    onPressed: () {
                      _controller.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    child: Text('Skip'),
                  ),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const WormEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.yellowAccent,
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                  //Next button
                  // tertiary operator used here
                  isLast
                      ? GestureDetector(
                          child: Text('Get Started'),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (ctx) {
                              return AuthScreen();
                            }));
                          },
                        )
                      : GestureDetector(
                          child: Text('Next'),
                          onTap: () {
                            _controller.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                        )
                  // nextMethod(),
                ])),
      ]),
    );
  }

  nextMethod() {
    if (_controller.page == 2) {
      return GestureDetector(
        child: Text('Get Started'),
        onTap: () {},
      );
    } else {
      return GestureDetector(
        child: Text('Next'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
            return AuthScreen();
          }));
        },
      );
    }
  }
}
