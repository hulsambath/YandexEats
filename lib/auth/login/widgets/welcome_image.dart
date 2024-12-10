import 'package:app_ui/generated/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Assets.images.welcome.image(
      fit: BoxFit.cover,
      width: size * 0.7,
      cacheWidth: size.toInt(),
    );
  }
}
