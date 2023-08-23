import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/app_style.dart';
import '../controllers/blocs/authentication/authentication_bloc.dart';

class AddAccount extends StatelessWidget {
  AddAccount({
    super.key,
  });

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Accounts',
              style: AppStyle.latoStyle.copyWith(fontSize: 19),
            ),
            GestureDetector(
              onTap: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogInEvent());
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.add),
            )
          ],
        ),
        if (user != null)
          ListTile(
            title: Text(
              user!.displayName!,
              style: AppStyle.latoStyle.copyWith(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              user!.email!,
              style: AppStyle.latoStyle.copyWith(
                fontSize: 15,
                color: Colors.grey,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        if (user != null)
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 2,
                color: Colors.grey,
              ),
              Ink(
                child: InkWell(
                  onTap: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogOutEvent());
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Sign Out',
                    style: AppStyle.latoStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
            ],
          )
      ],
    );
  }
}
