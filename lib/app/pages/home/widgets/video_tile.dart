import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_style.dart';
import '../../common/widgets/dash_btn.dart';

class VideoTile extends StatelessWidget {
  const VideoTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.30,
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.green,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Video title',
                          style: AppStyle.latoStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          'Channel 1.7M views 2 weaks age ',
                          style: AppStyle.latoStyle,
                        ),
                      ],
                    )
                  ],
                ),
                DashBTN(
                  isHomePage: true,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
