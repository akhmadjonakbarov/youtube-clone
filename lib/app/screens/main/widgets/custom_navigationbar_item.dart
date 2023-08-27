import 'package:flutter/material.dart';

import '../../../../constants/app_style.dart';

class CustomNavigationItem extends StatelessWidget {
  final int index;
  final Function(int) onTap;
  final String label;
  bool isActive;

  CustomNavigationItem({
    super.key,
    required this.index,
    required this.onTap,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: index == 2
          ? EdgeInsets.only(
              left: MediaQuery.sizeOf(context).width * 0.2,
            )
          : index == 1
              ? EdgeInsets.only(left: MediaQuery.sizeOf(context).width * 0.05)
              : EdgeInsets.zero,
      child: Ink(
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
      ),
    );
  }
}
