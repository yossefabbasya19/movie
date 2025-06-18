import 'package:flutter/material.dart';
import 'package:movies/core/colors_manager.dart';

class CustomElevationButton extends StatelessWidget {
  final void Function() onPressed;
  final String txt;
  final bool? isLoading;
  final EdgeInsetsGeometry? padding;
  final Color? buttonColor;
  final Color? textColor;

  const CustomElevationButton({
    super.key,
    required this.onPressed,
    required this.txt,
    this.isLoading = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.buttonColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: padding!,
      child: SizedBox(
        height: height * 0.07,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor ?? ColorsManager.yellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: onPressed,
          child:
              isLoading!
                  ? Center(
                    child: CircularProgressIndicator(
                      color: ColorsManager.white,
                    ),
                  )
                  : Text(
                    txt,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: textColor??ColorsManager.black
                    ),
                  ),
        ),
      ),
    );
  }
}
