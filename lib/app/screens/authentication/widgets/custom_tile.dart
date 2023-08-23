import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_style.dart';

class CustomTile extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final IconData icon;

  const CustomTile(
      {super.key,
      required this.onTap,
      required this.title,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 38,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(
                width: 15,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppStyle.latoStyle.copyWith(
                    fontSize: 17.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
