import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/app_style.dart';
import '../../../common/controllers/blocs/channel/channel_bloc.dart';
import '../../../common/controllers/blocs/video/video_bloc.dart';
import '../../upload_video/upload_video_screen.dart';
import 'custom_navigationbar_item.dart';

class CustomNavigationBar extends StatefulWidget {
  final Function(int) onChange;
  final int selectedIndex;
  CustomNavigationBar({
    super.key,
    required this.onChange,
    required this.selectedIndex,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  final List navigationBarItems = [
    'Home',
    'Shorts',
    'Subscription',
    'Library',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      height: 50,
      alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              navigationBarItems.length,
              (index) => CustomNavigationItem(
                index: index,
                onTap: (inx) {
                  widget.onChange(inx);
                },
                label: navigationBarItems[index],
                isActive: (widget.selectedIndex == index),
              ),
            ),
          ),
          Ink(
            height: 35,
            width: 35,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all()),
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  context: context,
                  builder: (context) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: MediaQuery.sizeOf(context).height * 0.3,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Create',
                              style: AppStyle.latoStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(
                                Icons.close,
                              ),
                            )
                          ],
                        ),
                        Ink(
                          height: 50,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                        create: (context) => ChannelBloc(),
                                      ),
                                      BlocProvider(
                                        create: (context) => VideoBloc(),
                                      ),
                                    ],
                                    child: VideoUploadScreen(),
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Icon(
                                    Icons.upload,
                                  ),
                                ),
                                Text(
                                  'Upload Video',
                                  style: AppStyle.latoStyle.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
