import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../localization/localization_export.dart';

class NoInternetCard extends StatelessWidget {
  const NoInternetCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(20),
          Text(
            AppLocalizations.of(context)!.oops_You_re_offline_check_your_connection_and_give_it_another_shot,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
          ),
          const Gap(20),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width / 1.6, 40),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(32),
                  bottomLeft: Radius.circular(32),
                ),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.try_again,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
