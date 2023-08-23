import 'package:flutter/material.dart';
import 'package:youtube_clone/app/pages/common/widgets/dash_btn.dart';

class HistoryTile extends StatelessWidget {
  const HistoryTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
        height: MediaQuery.sizeOf(context).height * 0.3,
        width: MediaQuery.sizeOf(context).width * 0.42,
        child: InkWell(
          onTap: () {
            print("object");
          },
          child: LayoutBuilder(
            builder: (context, constraints) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: constraints.maxHeight * 0.65,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How to get IELTS',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Channel',
                        )
                      ],
                    ),
                    DashBTN()
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
