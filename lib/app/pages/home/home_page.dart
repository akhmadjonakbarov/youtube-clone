import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/widgets/header.dart';
import 'widgets/video_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Header(),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => const VideoTile(),
            separatorBuilder: (context, index) => const SizedBox(
              height: 15,
            ),
            itemCount: 5,
          )
        ],
      ),
    );
  }
}
