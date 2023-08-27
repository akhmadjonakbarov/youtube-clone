import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBTN extends StatelessWidget {
  String page;

  DashBTN({super.key, required this.page});

  Widget? adaptiveSheet;

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
          context: context,
          builder: (context) {
            switch (page) {
              case 'homepage':
                adaptiveSheet = Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                );
                break;
              case 'videotab':
                adaptiveSheet = Container(  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(page),
                );
                break;
              default:
                adaptiveSheet = Container(  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text('Bunday screen mavjud emas!'),
                );
                break;
            }
            return adaptiveSheet!;
          },
        ),
        child: const Icon(
          CupertinoIcons.ellipsis_vertical,
          size: 18,
        ),
      ),
    );
  }
}
