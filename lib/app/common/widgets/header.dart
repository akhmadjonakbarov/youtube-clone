import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/app/screens/authentication/auth_wrapper.dart';
import 'package:youtube_clone/constants/app_style.dart';
import '../../pages/home/widgets/show_notification.dart';

class Header extends StatelessWidget {
  Header({
    super.key,
  });

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/youtube.png",
              height: 25,
            ),
            Container(
              decoration: const BoxDecoration(),
              width: size.width * 0.35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ShowNotification(),
                  IconButton(
                    splashRadius: 25,
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.search),
                  ),
                  Ink(
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => const AuthWrapper(),
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        child: auth.currentUser != null
                            ? Align(
                                alignment: Alignment.center,
                                child: Text(
                                  auth.currentUser!.displayName!.characters
                                      .elementAt(0),
                                  textAlign: TextAlign.center,
                                  style: AppStyle.latoStyle.copyWith(),
                                ),
                              )
                            : const Icon(
                                Icons.person,
                              ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
