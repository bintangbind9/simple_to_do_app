import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/constants/app_styles.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final IconData? icon;

  const CommonButton({
    super.key,
    this.onPressed,
    required this.text,
    this.textColor = AppStyles.grayscaleOffWhite,
    this.backgroundColor = AppStyles.primaryColor,
    this.borderColor = AppStyles.primaryColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: onPressed == null ? AppStyles.disable : backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: onPressed == null ? AppStyles.disable : borderColor,
                width: 1),
          ),
          child: icon == null
              ? textWidget()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    FaIcon(
                      icon,
                      color:
                          onPressed == null ? AppStyles.disableText : textColor,
                    ),
                    textWidget(),
                  ],
                ),
        ),
      ),
    );
  }

  Text textWidget() {
    return Text(
      text,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: onPressed == null ? AppStyles.disableText : textColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
