import 'package:flutter/material.dart';
import 'package:space_x_demo/constants/constants.dart';

class CircularLoadMore extends StatelessWidget {
  const CircularLoadMore({super.key, required this.loadMoreText});

  final String loadMoreText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const RepaintBoundary(
          child: SizedBox(
            width: Constants.loadingMoreCircularSize,
            height: Constants.loadingMoreCircularSize,
            child: CircularProgressIndicator(),
          ),
        ),
        const SizedBox(width: Constants.md),
        Flexible(
          child: Text(
            loadMoreText,
            style: Theme.of(context).textTheme.titleLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
