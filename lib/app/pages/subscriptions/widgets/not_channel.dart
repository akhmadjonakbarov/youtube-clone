import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_style.dart';

class NotChannel extends StatelessWidget {
  const NotChannel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.35,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            'assets/images/youtube_bg.png',
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'New videos right to you',
                  style: AppStyle.latoStyle.copyWith(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 25),
                  child: Text(
                    'Subscribe to get the last videos from channels you love',
                    textAlign: TextAlign.center,
                    style: AppStyle.latoStyle.copyWith(
                      fontSize: 16,
                      color: AppColors.greyColor,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
