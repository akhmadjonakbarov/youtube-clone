import 'package:flutter/material.dart';
import 'package:youtube_clone/app/pages/common/widgets/header.dart';
import 'widgets/history_part.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
           Header(),
          HistoryPart(),
        ],
      ),
    );
  }
}
