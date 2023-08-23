import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/app/screens/profile/profile_page.dart';
import 'package:youtube_clone/constants/app_colors.dart';
import 'package:youtube_clone/constants/app_style.dart';
import '../../pages/common/widgets/liner.dart';
import '../../pages/common/widgets/same_part.dart';

import 'controllers/blocs/authentication/authentication_bloc.dart';
import 'widgets/add_account.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationLoadingState) {
          return const Scaffold(
            body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (state is AuthenticationLoginState) {
          return ProfileScreen();
        } else if (state is AuthenticationLogOutState) {
          return AuthenticationScreen();
        }
        return AuthenticationScreen();
      },
    );
  }
}

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.3,
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.2,
                  ),
                  child: Image.asset(
                    'assets/images/auth.png',
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Text(
                  'Do more with YouTube',
                  textAlign: TextAlign.center,
                  style: AppStyle.latoStyle.copyWith(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Sign in now to upload, save, and comment on videos',
                    textAlign: TextAlign.center,
                    style: AppStyle.latoStyle.copyWith(
                      fontSize: 15,
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Ink(
                    height: 38,
                    width: 90,
                    decoration: const BoxDecoration(color: AppColors.blueColor),
                    child: InkWell(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog.adaptive(
                          content: AddAccount(),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'sign in'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: AppStyle.latoStyle.copyWith(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Liner(),
                SamePart()
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text('Privacy Policy Terms of Service'),
            )
          ],
        ),
      ),
    );
  }
}
