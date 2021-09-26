import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invest_naija/constants.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton(
      {@required this.onPressed,
      this.title,
      this.child,
      this.height = 52,
      this.color,
      this.textColor,
      this.minWidth = double.infinity,
      this.borderRadius = const BorderRadius.all(Radius.circular(25)),
      this.elevation = 1,
      this.fontSize,
      this.showIcon = false});

  final Widget child;
  final String title;
  final Function() onPressed;
  final double height;
  final Color color;
  final Color textColor;
  final double fontSize;
  final BorderRadiusGeometry borderRadius;
  final double minWidth;
  final double elevation;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
          // gradient: color != null
          //     ? null
          //     : LinearGradient(
          //         begin: Alignment.topRight,
          //         end: Alignment.bottomLeft,
          //         stops: [
          //           0,
          //           1,
          //         ],
          //         colors: [
          //           InvestAppColors.secondaryButton,
          //           InvestAppColors.primaryButton,
          //         ],
          //       ),
          borderRadius: borderRadius,
          color: color ?? theme.buttonColor,
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        width: minWidth,
        height: height,
        child: child != null
            ? child
            : showIcon
                ? Row(
                    children: [
                      SizedBox(
                        width: 24,
                      ),
                      Opacity(
                        opacity: 0,
                        child: Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: Constants.blackColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        title,
                        style: theme.textTheme.bodyText2.copyWith(
                            color: textColor ?? Constants.blackColor,
                            fontWeight: FontWeight.w700,
                            fontSize: fontSize),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: Constants.blackColor,
                      ),
                      SizedBox(
                        width: 24,
                      )
                    ],
                  )
                : Text(
                    title,
                    style: theme.textTheme.bodyText2.copyWith(
                        color: textColor ?? Constants.blackColor,
                        fontWeight: FontWeight.w700,
                        fontSize: fontSize),
                  ),
      ),
    );
  }
}
