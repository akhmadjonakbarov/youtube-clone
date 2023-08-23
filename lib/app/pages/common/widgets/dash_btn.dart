import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBTN extends StatelessWidget {
  bool isHomePage;
  DashBTN({super.key, this.isHomePage = false});

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 35,
      // width: 35,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      child: InkWell(
        radius: 25,
        borderRadius: BorderRadius.circular(50),
        onTap: () => showBottomSheet(
          backgroundColor: Colors.transparent,
          // shape: const RoundedRectangleBorder(
          //   borderRadius: BorderRadius.vertical(
          //     top: Radius.circular(20),
          //   ),
          // ),
          context: context,
          builder: (context) => isHomePage
              ? Container(
                  margin: const EdgeInsets.all(10),
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.all(10),
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
        ),
        child: const Icon(
          CupertinoIcons.ellipsis_vertical,
          size: 18,
        ),
      ),
    );
  }
}
