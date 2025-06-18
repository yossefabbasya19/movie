import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/assets_manager.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/provider/language_provider.dart';
import 'package:movies/core/shared_pref/shared_pref.dart';
import 'package:provider/provider.dart';

class CustomToggleSwitch extends StatefulWidget {
  const CustomToggleSwitch({super.key});

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
    int toggleCurrent = SharedPref().getLanguage == "en"?0:1;

  @override
  Widget build(BuildContext context) {
    LanguageProvider provider=Provider.of<LanguageProvider>(context);
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return   AnimatedToggleSwitch<int?>.rolling(
      style: ToggleStyle(
        backgroundColor: Colors.transparent,
        borderColor: ColorsManager.yellow,
        indicatorColor: Colors.transparent,
      ),
      height: height * 0.05,
      allowUnlistedValues: true,
      styleAnimationType: AnimationType.onHover,
      current: toggleCurrent,
      values: const [0, 1],
      iconBuilder: (value, foreground) {
        if (value == 0) {
         //
          return Image(image: AssetImage(AssetsManager.usaFlag));
        } else {
          //provider.switchBetweenLanguage("ar");
          return Image(image: AssetImage(AssetsManager.egyptFlag));
        }
      },
      onChanged: (i) {
        if(i == 0 ){
          provider.switchBetweenLanguage("en");
        }else{
          provider.switchBetweenLanguage("ar");
        }
        setState(() => toggleCurrent = i!);
      },
      customStyleBuilder: (context, local, global) {
        final color =
        local.isValueListed
            ? null
            : Theme.of(context).colorScheme.error;
        return ToggleStyle(borderColor: color, indicatorColor: color);
      },
    );
  }
}
