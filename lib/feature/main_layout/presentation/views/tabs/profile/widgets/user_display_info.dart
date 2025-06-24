import 'package:flutter/material.dart';
import 'package:movies/core/constace.dart';
import 'package:movies/core/models/user_Dm.dart';

class UserDisplayInfo extends StatelessWidget {
  const UserDisplayInfo({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.2627906976744186,
            child: Column(
              children: [
                Image(
                  fit: BoxFit.fill,
                  width: width * 0.2744186046511628,
                  height: height * 0.1266094420600858,
                  image: AssetImage(
                    avatars[UserDm.currentUser!.avatar],
                  ),
                ),
                SizedBox(height: height * 0.01),
                FittedBox(
                  child: Text(
                    UserDm.currentUser!.userName,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: width * 0.05),
          SizedBox(
            width: width * 0.2627906976744186,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${UserDm.currentUser!.watchList.length}",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
                ),
                FittedBox(
                  child: Text(
                    "Watch List",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: width * 0.05),
          SizedBox(
            width: width * 0.2627906976744186,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${UserDm.currentUser!.history.length}",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
                ),
                FittedBox(
                  child: Text(
                    "History",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
