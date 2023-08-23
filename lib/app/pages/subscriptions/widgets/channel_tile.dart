import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_style.dart';

class ChannelTile extends StatelessWidget {
  final String channelURL;
  final String channelName;

  const ChannelTile({
    super.key,
    required this.channelURL,
    required this.channelName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 35),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(channelURL),
            radius: MediaQuery.sizeOf(context).height * .05,
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.13,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                channelName,
                style: AppStyle.latoStyle.copyWith(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 8),
                child: Text(
                  '400K subscribers 174 videos',
                  style: AppStyle.latoStyle.copyWith(
                    fontSize: 12,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
              Ink(
                child: InkWell(
                  onTap: () => print('press '),
                  child: Text(
                    'SUBSCRIBE',
                    style: AppStyle.latoStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
