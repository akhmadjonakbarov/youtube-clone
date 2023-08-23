import 'package:flutter/material.dart';
import 'package:youtube_clone/app/pages/history/library_page.dart';
import 'package:youtube_clone/app/pages/home/home_page.dart';
import 'package:youtube_clone/app/pages/subscriptions/subscriptions_page.dart';
import 'package:youtube_clone/constants/app_style.dart';

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
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        height: 50,
        alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _NavigationItem(
                      index: 0,
                      onTap: (index) {
                        _changePage(index);
                      },
                      label: 'Home',
                      isActive: (_selectedIndex == 0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 45),
                      child: _NavigationItem(
                        index: 1,
                        onTap: (index) {
                          _changePage(index);
                        },
                        label: 'Shorts',
                        isActive: (_selectedIndex == 1),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: _NavigationItem(
                        index: 2,
                        onTap: (index) {
                          _changePage(index);
                        },
                        label: 'Subscriptions',
                        isActive: (_selectedIndex == 2),
                      ),
                    ),
                    _NavigationItem(
                      index: 3,
                      onTap: (index) {
                        _changePage(index);
                      },
                      label: 'Library',
                      isActive: (_selectedIndex == 3),
                    ),
                  ],
                )
              ],
            ),
            Ink(
              height: 35,
              width: 35,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, border: Border.all()),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    context: context,
                    builder: (context) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: MediaQuery.sizeOf(context).height * 0.3,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Create',
                                style: AppStyle.latoStyle.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(
                                  Icons.close,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  final int index;
  final Function(int) onTap;
  final String label;
  bool isActive;

  _NavigationItem({
    super.key,
    required this.index,
    required this.onTap,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      // width: MediaQuery.sizeOf(context).width * 0.09,
      // decoration: BoxDecoration(border: Border.all()),
      child: InkWell(
        onTap: () {
          onTap(index);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isActive ? Icons.home : Icons.home_outlined),
            Text(
              label,
              style: AppStyle.latoStyle.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
