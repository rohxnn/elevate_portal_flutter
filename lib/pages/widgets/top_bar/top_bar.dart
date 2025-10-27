import 'package:elevate_portal_flutter/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;

  const TopBar({Key? key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3
        )
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(preferredSize: const Size.fromHeight(1),
       child: Container(
        height: 1,
        color: Colors.grey.shade200,
       )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}