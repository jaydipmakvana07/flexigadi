import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';

class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double svgSize = screenWidth * 0.6; // Adjust the percentage as needed

    return Column(
      children: [
        Text(
          "documents".toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        const SizedBox(height: defaultPadding ),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset(
                "assets/icons/document.svg",
                width: svgSize,
                height: svgSize,
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding ),
      ],
    );
  }
}
