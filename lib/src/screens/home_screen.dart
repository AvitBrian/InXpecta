import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inxpecta/src/features/authentication/providers/auth_provider.dart';
import 'package:inxpecta/src/features/home/reports_room.dart';
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

  final List _pages = [
    const SizedBox(child: StatsPage()),
    const SizedBox(child: ReportRoom()),
    // const SizedBox(child: ProfilePage()),
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
      systemNavigationBarColor: MyConstants.primaryColor,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: MyConstants.primaryColor,
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
        backgroundColor: MyConstants.primaryColor,
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
        items: const [
          BottomNavigationBarItem(
            label: "Stats",
            icon: Icon(Icons.bar_chart_outlined),
          ),
          BottomNavigationBarItem(
            label: "Reports",
            icon: Icon(Icons.data_saver_off_rounded),
          ),
          // BottomNavigationBarItem(
          //   label: "Profile",
          //   icon: Icon(Icons.account_circle_rounded),
          // ),
        ],
      ),
    );
  }
}
