import 'dart:io';

import 'package:flutter/material.dart';

import 'package:youtube_clone/app/pages/history/library_page.dart';
import 'package:youtube_clone/app/pages/home/home_page.dart';
import 'package:youtube_clone/app/pages/subscriptions/subscriptions_page.dart';
import 'widgets/custom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List _pages = const [
    HomePage(),
    SubScriptionsPage(),
    SubScriptionsPage(),
    LibraryPage(),
  ];

  void _changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CustomNavigationBar(
        onChange: _changePage,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}




// Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     _NavigationItem(
              //       index: 0,
              //       onTap: (index) {
              //         onChange(index);
              //       },
              //       label: 'Home',
              //       isActive: (selectedIndex == 0),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(left: 45),
              //       child: _NavigationItem(
              //         index: 1,
              //         onTap: (index) {
              //           onChange(index);
              //         },
              //         label: 'Shorts',
              //         isActive: (selectedIndex == 1),
              //       ),
              //     ),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(right: 25),
              //       child: _NavigationItem(
              //         index: 2,
              //         onTap: (index) {
              //           onChange(index);
              //         },
              //         label: 'Subscriptions',
              //         isActive: (selectedIndex == 2),
              //       ),
              //     ),
              //     _NavigationItem(
              //       index: 3,
              //       onTap: (index) {
              //         onChange(index);
              //       },
              //       label: 'Library',
              //       isActive: (selectedIndex == 3),
              //     ),
              //   ],
              // )