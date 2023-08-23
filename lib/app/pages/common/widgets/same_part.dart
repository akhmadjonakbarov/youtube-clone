import 'package:flutter/material.dart';

import '../../../../constants/app_style.dart';
import '../../../screens/authentication/widgets/custom_tile.dart';
import 'liner.dart';

class SamePart extends StatelessWidget {
  const SamePart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomTile(
            onTap: () {},
            title: 'Settings',
            icon: Icons.settings,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTile(
            onTap: () {},
            title: 'Help & feedback',
            icon: Icons.help_outline,
          ),
          const Liner(),
          Ink(
            height: 38,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // Icon(),
                    const SizedBox(
                      width: 15,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'YouTube Kids',
                        textAlign: TextAlign.center,
                        style: AppStyle.latoStyle.copyWith(
                          fontSize: 17.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
