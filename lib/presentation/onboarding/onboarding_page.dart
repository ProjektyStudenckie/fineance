import 'package:auto_route/auto_route.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:fineance/style/typography.dart';
import 'package:flutter/material.dart';
import 'package:fineance/extension/context_extension.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageViewController = PageController();
  var _currentPage = 0;

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
                child: TextButton(onPressed: () {
                  context.router.replace(const TabRoute());
                }, child: const Text("Pomiń")),
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
        children: [
          const Spacer(),
          Text("Oszczędzaj!", style: context.typo.extraLarge()),
          const SizedBox(height: 12),
          const Text("Zacznij kontrolować wydatki i zbieraj na wymarzone cele", textAlign: TextAlign.center),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildSecondPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          const Spacer(),
          Text("Inwestuj!", style: context.typo.extraLarge()),
          const SizedBox(height: 12),
          const Text("Pomnóż swoje pieniadze dzięki dobrze zaplanowanym inwwestycjom", textAlign: TextAlign.center),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildThirdPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          const Spacer(),
          Text("Witaj!", style: context.typo.extraLarge()),
          const SizedBox(height: 12),
          const Text("Nasza aplikacja pomoże Ci lepiej zarządzać pieniędzmi", textAlign: TextAlign.center),
          const Spacer(),
        ],
      ),
    );
  }
}
