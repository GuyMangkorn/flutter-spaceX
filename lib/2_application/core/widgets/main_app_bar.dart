import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:space_x_demo/constants/constants.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  const MainAppBar({
    required this.title,
    super.key,
  });

  final String title;

  @override
  PreferredSizeWidget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final canPop = Navigator.of(context).canPop();
    return AppBar(
      elevation: 0,
      flexibleSpace: Padding(
        padding: EdgeInsets.only(
          top: topPadding,
          left: Constants.sm,
          right: Constants.sm,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            canPop ? const SizedBox(width: 50) : const SizedBox(),
            canPop
                ? const SizedBox()
                : RepaintBoundary(
                    child: Lottie.asset(
                      'assets/lotties/energy_rocket.json',
                      repeat: true,
                    ),
                  ),
            const SizedBox(width: Constants.xs),
            Flexible(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                maxLines: 1,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
