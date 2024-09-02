import 'package:crave_wave_app/view/onboarding/onboarding_info.dart';

class OnboardinItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
      title: 'Welcome to Cravewave',
      animation: 'asset/animation/bowl.json',
      description: 'Discover the Best Food Deals in Town',
      height: 305
    ),
    OnboardingInfo(
      title: 'Get Started as Restaurant Partner',
      animation: 'asset/animation/fast_food.json',
      description: 'Manage deals and reach more customers.',
      height: 303.5
    ),
    OnboardingInfo(
      title: 'Get Started as User',
      animation: 'asset/animation/loading_burger.json',
      description: 'Find and enjoy the best food deals near you.',
      height: 301

    )
  ];
}
