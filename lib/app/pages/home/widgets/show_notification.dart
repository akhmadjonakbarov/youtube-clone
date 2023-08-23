import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_style.dart';
import '../../../screens/notification/notification_screen.dart';

class ShowNotification extends StatelessWidget {
  const ShowNotification({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => const NotificationScreen(),
            ),
          );
        },
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            const Icon(
              CupertinoIcons.bell,
              size: 26,
            ),
            Container(
              height: 19,
              width: 19,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                "19",
                textAlign: TextAlign.center,
                style: AppStyle.latoStyle.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
