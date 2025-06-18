import 'package:flutter/material.dart';
import 'package:movies/core/widgets/custom_text_button.dart';

class CustomWidgetDisplayTwoText extends StatelessWidget {
  final String textOne;
  final String textTwo;
  final void Function()? onPressed;

  const CustomWidgetDisplayTwoText({
    super.key,
    required this.textOne,
    required this.textTwo,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textOne,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          CustomTextButton(onPressed: onPressed, textTwo: textTwo),
        ],
      ),
    );
  }
}
