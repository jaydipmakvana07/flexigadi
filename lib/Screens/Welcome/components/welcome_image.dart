import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double svgSize = screenWidth * 0.9; // Adjust the percentage as needed

    return Column(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            "WELCOME",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              color: kPrimaryColor,
            ),
          ),
        ),
        const SizedBox(height: defaultPadding / 100),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset(
                "assets/icons/welcome.svg",
                width: svgSize,
                height: svgSize,
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding / 2),
      ],
    );
  }
}
