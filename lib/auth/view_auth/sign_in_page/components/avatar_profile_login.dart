import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';

class AvatarProfileLogin extends StatelessWidget {
  const AvatarProfileLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      width: 120,
      height: 120,
      spread: 2,
      depth: 2,
      curveType: CurveType.convex,
      color: const Color.fromRGBO(
        162,
        132,
        185,
        1,
      ),
      borderRadius: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: Image.asset(
          "assets/profile_picture.jpeg",
          fit: BoxFit.cover,
          width: 120,
          height: 120,
        ),
      ),
    );
  }
}
