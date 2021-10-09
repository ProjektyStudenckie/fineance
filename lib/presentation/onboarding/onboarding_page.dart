import 'package:auto_route/auto_route.dart';
import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/localization/keys.g.dart';
import 'package:fineance/localization/utils.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageViewController = PageController();
  var _currentPage = 0;

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 16.0),
                child: TextButton(
                    onPressed: () {
                      context.router.replace(const TabRoute());
                    },
                    child: Text(translate(LocaleKeys.onboarding_skip))),
              ),
            ),
            Expanded(
              child: PageView(
                physics: const BouncingScrollPhysics(),
                controller: _pageViewController,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  _buildFirstPage(),
                  _buildSecondPage(),
                  _buildThirdPage(),
                ],
              ),
            ),
            _buildPageIndicators(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIndicator(_currentPage == 0, () {
            _pageViewController.animateToPage(0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut);
          }),
          _buildIndicator(_currentPage == 1, () {
            _pageViewController.animateToPage(1,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut);
          }),
          _buildIndicator(_currentPage == 2, () {
            _pageViewController.animateToPage(2,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut);
          }),
        ],
      ),
    );
  }

  Widget _buildIndicator(bool isActive, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 11.0,
          width: isActive ? 25.0 : 20.0,
          decoration: BoxDecoration(
              color: isActive ? Colors.blue.shade200 : Colors.blue[50],
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.blue.shade200, width: 2)),
        ),
      ),
    );
  }

  Widget _buildFirstPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(translate(LocaleKeys.onboarding_save),
              style: context.typo.extraLarge()),
          const SizedBox(height: 12),
          Text(translate(LocaleKeys.onboarding_save_description),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildSecondPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(translate(LocaleKeys.onboarding_invest),
              style: context.typo.extraLarge()),
          const SizedBox(height: 12),
          Text(translate(LocaleKeys.onboarding_invest_description),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildThirdPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(translate(LocaleKeys.onboarding_welcome),
              style: context.typo.extraLarge()),
          const SizedBox(height: 12),
          Text(translate(LocaleKeys.onboarding_welcome_description),
              textAlign: TextAlign.center),
          const SizedBox(height: 12),
          InkWell(
              onTap: () {
                context.router.replace(const TabRoute());
              },
              borderRadius: BorderRadius.circular(50),
              splashColor: Colors.blue[400],
              child: Ink(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blue[200]),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }
}
