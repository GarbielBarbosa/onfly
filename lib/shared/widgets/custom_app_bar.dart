import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onfly/shared/theme/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });
  final String title;

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: SvgPicture.asset(
              'assets/svg.svg',
              width: 30,
              height: 30,
              colorFilter: ColorFilter.mode(DefaultColors().primary, BlendMode.srcIn),
            ),
          ),
          const SizedBox(width: 10), // Espaçamento entre o ícone e o texto
          Text(title), // Texto do AppBar
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
