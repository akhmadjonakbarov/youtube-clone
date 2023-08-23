import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/app/screens/history/history_screen.dart';
import 'package:youtube_clone/constants/app_style.dart';

import 'history_tile.dart';

class HistoryPart extends StatelessWidget {
  const HistoryPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.history),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'History',
                    style: AppStyle.latoStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => const HistoryScreen(),
                  ),
                ),
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.sizeOf(context).height * 0.2,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => const HistoryTile(),
            separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),
            itemCount: 3,
          ),
        ),
      ],
    );
  }
}
