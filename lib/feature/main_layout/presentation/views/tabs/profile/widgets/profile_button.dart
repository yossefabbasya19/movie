import 'package:flutter/material.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/firebase_servise/firebase_service.dart';
import 'package:movies/core/models/user_Dm.dart';
import 'package:movies/core/my_routes/my_routes.dart';
import 'package:movies/core/shared_pref/shared_pref.dart';
import 'package:movies/core/widgets/custom_elevation_button.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return SizedBox(

      height: height * 0.0800858369098712,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CustomElevationButton(
              padding:const  EdgeInsets.only(
                left: 16,
                right: 5,
                top: 4,
                bottom: 4,
              ),
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.editProfile);
              },
              txt: "Edit Profile",
            ),
          ),
          Expanded(
            child: CustomElevationButton(
              buttonColor: ColorsManager.red,
              textColor: ColorsManager.white,
              padding:const  EdgeInsets.only(
                right: 16,
                left: 5,
                top: 4,
                bottom: 4,
              ),
              onPressed: () async{
                UserDm.currentUser=null;
                await SharedPref().removeToken();
                Navigator.pushReplacementNamed(context,MyRoutes.login);
              },
              txt: "Exit",
            ),
          ),
        ],
      ),
    );
  }
}
