import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/app/common/widgets/header.dart';
import 'package:youtube_clone/app/utilities/random_image.dart';
import 'package:youtube_clone/constants/app_colors.dart';
import 'package:youtube_clone/constants/app_style.dart';

import 'widgets/channel_tile.dart';
import 'widgets/not_channel.dart';

class SubScriptionsPage extends StatelessWidget {
  const SubScriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Header(),
          NotChannel(),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Channel Category',
                  style: AppStyle.latoStyle
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => ChannelTile(
                    channelName:
                        "${Faker().person.firstName()} ${Faker().person.lastName()}",
                    channelURL: RandomImage.randomPickUrl(),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.05,
                  ),
                  itemCount: 5,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
