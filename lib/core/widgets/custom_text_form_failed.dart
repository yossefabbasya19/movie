import 'package:flutter/material.dart';
import 'package:movies/core/colors_manager.dart';

class CustomTextFormFailed extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String prefixIconPath;
  final String? Function(String?)? validator;
 final FocusNode? focusNode;
  final bool isPassword;
final void Function(String)?onFieldSubmitted;
  const CustomTextFormFailed({
    super.key,
    this.controller,
    required this.label,
    required this.prefixIconPath,
    this.validator,
    this.isPassword = false, this.onFieldSubmitted, this.focusNode,
  });

  @override
  State<CustomTextFormFailed> createState() => _CustomTextFormFailedState();
}

class _CustomTextFormFailedState extends State<CustomTextFormFailed> {
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextFormField(
        focusNode: widget.focusNode,
        obscureText: obscureText,
        keyboardType: TextInputType.name,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        onFieldSubmitted: widget.onFieldSubmitted,
        cursorColor: ColorsManager.white,
        controller: widget.controller,
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.label,
          prefixIcon: Image(image: AssetImage(widget.prefixIconPath)),
          suffixIcon:
              widget.isPassword
                  ? IconButton(
                    onPressed: () {
                      obscureText = !obscureText;
                      setState(() {});
                    },
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  )
                  : SizedBox(),
        ),
      ),
    );
  }
}
