import 'package:flutter/material.dart';

class Liner extends StatelessWidget {
  const Liner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      height: 1,
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
    );
  }
}
