import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/app/pages/common/widgets/liner.dart';
import 'package:youtube_clone/app/pages/common/widgets/same_part.dart';
import 'package:youtube_clone/app/screens/authentication/widgets/custom_tile.dart';
import 'package:youtube_clone/app/screens/channel/channel_wrapper.dart';
import 'package:youtube_clone/app/screens/profile/widgets/profile_info.dart';
import 'package:youtube_clone/constants/app_style.dart';

import '../channel/controllers/blocs/channel/channel_bloc.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;

  @override
  void didChangeDependencies() {
    setState(() {
      user = FirebaseAuth.instance.currentUser;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                splashRadius: 20,
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.close,
                  size: 30,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.03,
            ),
            ProfileInfo(
              user: user!,
            ),
            Ink(
              child: InkWell(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Manage your Google Account',
                    textAlign: TextAlign.center,
                    style: AppStyle.latoStyle.copyWith(
                      fontSize: 15,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const Liner(),
            CustomTile(
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => BlocProvider<ChannelBloc>(
                      create: (context) => ChannelBloc(),
                      child: const ChannelWrapper(),
                    ),
                  ),
                );
              },
              title: 'Your Channel',
              icon: Icons.person_2_outlined,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.01,
            ),
            CustomTile(
              onTap: () {},
              title: 'Turn on Incognito',
              icon: Icons.security,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.01,
            ),
            CustomTile(
              onTap: () {},
              title: 'Add account',
              icon: Icons.person_add_outlined,
            ),
            const Liner(),
            const SamePart(),
            const Spacer(),
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text('Privacy Policy Terms of Service'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
