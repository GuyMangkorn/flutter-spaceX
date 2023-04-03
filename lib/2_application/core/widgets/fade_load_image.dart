import 'package:flutter/material.dart';
import 'package:space_x_demo/constants/constants.dart';
import 'package:space_x_demo/constants/mock_constants.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as anno;
import 'package:widgetbook/widgetbook.dart';

@anno.WidgetbookUseCase(name: 'Default', type: FadeLoadImage)
Widget fadeLoadImagePlaceholderUseCase(BuildContext context) {
  return Center(
    child: FadeLoadImage(
      image: context.knobs.options(
        label: 'Image provider',
        options: const [
          Option(label: 'Placeholder', value: ''),
          Option(label: 'Network image', value: MockConstants.mockNetworkURL)
        ],
      ),
      width: context.knobs.slider(
        label: 'Width',
        max: 1000,
        min: 100,
        initialValue: 200,
      ),
      height: context.knobs.slider(
        label: 'Height',
        max: 1000,
        min: 100,
        initialValue: 200,
      ),
    ),
  );
}

class FadeLoadImage extends StatelessWidget {
  const FadeLoadImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  });

  final double? width;
  final double? height;
  final BoxFit? fit;
  final String image;

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty) {
      return Opacity(
        opacity: Constants.baseOpacity,
        child: Image(
          image: const AssetImage('assets/images/placeholder.jpeg'),
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Stack(
        alignment: Alignment.center,
        children: [
          const Center(child: CircularProgressIndicator()),
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: image,
            height: height,
            width: width,
            fit: fit,
          )
        ],
      );
    }
  }
}
