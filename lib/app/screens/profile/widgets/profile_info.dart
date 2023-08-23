import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_style.dart';
import '../../authentication/widgets/add_account.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: AddAccount(),
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              child: Text(
                user.displayName!.characters.elementAt(0),
                textAlign: TextAlign.center,
                style: AppStyle.latoStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.04,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName!,
                  style: AppStyle.latoStyle.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  user.email!,
                  style: AppStyle.latoStyle.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
            const Spacer(),
            const Icon(CupertinoIcons.right_chevron)
          ],
        ),
      ),
    );
  }
}
