import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '/view/view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> imgList = [
    ImageAssets.slide1,
    ImageAssets.slide2,
    ImageAssets.slide3,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(Iconsax.menu),
          tooltip: "Back",
        ),
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return const Notif();
              }));
            },
            icon: const Icon(Iconsax.notification_bing),
            tooltip: "Notification",
          )
        ],
      ),
      drawer: Sidebar(refresh: () {}),
      // bottomNavigationBar: NavigationBar(
      //   height: 60,
      //   selectedIndex: 2,
      //   elevation: 0,
      //   indicatorShape: const CircleBorder(side: BorderSide()),
      //   destinations: const [
      //     NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
      //     NavigationDestination(icon: Icon(Iconsax.building), label: "Profile"),
      //     NavigationDestination(icon: Icon(Iconsax.setting), label: "Profile"),
      //     NavigationDestination(icon: Icon(Iconsax.profile), label: "Profile")
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text("Temple Photos",
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                CarouselSlider.builder(
                  itemCount: imgList.length,
                  itemBuilder: (context, index, realIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        imgList[index],
                        fit: BoxFit.contain,
                        width: double.infinity,
                      ),
                    );
                  },
                  options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlay: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}