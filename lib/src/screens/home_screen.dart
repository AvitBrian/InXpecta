import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inxpecta/src/features/authentication/providers/auth_provider.dart';
import 'package:inxpecta/src/features/home/profile_page.dart';
import 'package:inxpecta/src/features/home/report_page.dart';
import 'package:inxpecta/src/features/home/stats_page.dart';
import 'package:inxpecta/src/utils/constants.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title});

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AuthStateProvider authStateProvider;
  int currentIndex = 1;
  final PageController _pageController = PageController(initialPage: 1);

  final NotchBottomBarController _NotchpageController =
      NotchBottomBarController();
  final List _pages = [
    const SizedBox(child: StatsPage()),
    const SizedBox(child: ReportPage()),
    const SizedBox(child: ProfilePage()),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authStateProvider = Provider.of<AuthStateProvider>(context, listen: true);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: MyConstants.navColor,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: MyConstants.backgroundColor,
      body: SafeArea(
        child: PageView.builder(
          itemCount: _pages.length,
          controller: _pageController,
          itemBuilder: (BuildContext, currentIndex) {
            return Center(child: _pages[currentIndex]);
          },
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black45,
        type: BottomNavigationBarType.fixed,
        iconSize: 25,
        enableFeedback: true,
        elevation: 30,
        backgroundColor: MyConstants.navColor,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
            );
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Stats",
            icon: Icon(Icons.bar_chart_outlined),
          ),
          BottomNavigationBarItem(
            label: "Report",
            icon: Icon(Icons.data_saver_off_rounded),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.account_circle_rounded),
          ),
        ],
      ),
    );
  }
}
