import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/constants/keys.dart';
import 'package:crave_wave_app/view/login/login_view.dart';
import 'package:crave_wave_app/view/onboarding/onboarding_items.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final controller = OnboardinItems();
  final pageController = PageController();
  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 20,
        ),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => pageController.jumpToPage(
                      controller.items.length - 1,
                    ),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.items.length,
                    onDotClicked: (index) => pageController.animateToPage(
                      index,
                      duration: const Duration(
                        milliseconds: 600,
                      ),
                      curve: Curves.easeInOut,
                    ),
                    effect: const JumpingDotEffect(
                        activeDotColor: primaryColor, verticalOffset: 15),
                  ),
                  TextButton(
                    onPressed: () => pageController.nextPage(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                  )
                ],
              ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          onPageChanged: (index) =>
              setState(() => isLastPage = controller.items.length - 1 == index),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(controller.items[index].animation,
                    height: controller.items[index].height),
                Text(
                  controller.items[index].title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  controller.items[index].description,
                  style: const TextStyle(fontSize: 20, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getStarted() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 55,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: TextButton(
        onPressed: () async {
          final pref = await SharedPreferences.getInstance();

          pref.setBool(isOnboardingDone, true);

          try {
            if (!mounted) {
              return;
            }
          } catch (_) {}

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginView(),
            ),
          );
        },
        child: const Text(
          'Get Started',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
