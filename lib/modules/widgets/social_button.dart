import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String imageAsset;
  final double height;
  final double width;
  final VoidCallback onPressed;

  const SocialButton({
    Key key,
    this.imageAsset,
    this.height,
    this.width,
    @required this.onPressed,
  })  : assert(
          onPressed != null,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(right: 8.0, bottom: 50.0),
        child: ClipOval(
          child: Image.asset(
            imageAsset,
            height: height,
            width: width,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
