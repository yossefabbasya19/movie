import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/constace.dart';
import 'package:movies/feature/edit_profile/presentation/view_model/edit_profile_cubit.dart';

class CustomGridView extends StatefulWidget {
  final int selectAvatar;
  final EditProfileCubit cubit;

  const CustomGridView({
    super.key,
    required this.selectAvatar,
    required this.cubit,
  });

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  late int selectAvatar;

  @override
  void initState() {
    selectAvatar = widget.selectAvatar;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return SizedBox(
      width: width - 30,
      height: height * 0.48,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 3.2,
        ),
        itemCount: avatars.length,
        itemBuilder: (context, index) {
          return selectAvatar == index
              ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: ColorsManager.yellowLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: ColorsManager.yellow),
                  ),
                  child: Image(image: AssetImage(avatars[index])),
                ),
              )
              : GestureDetector(
                onTap: () {
                  selectAvatar = index;
                  widget.cubit.selectAvatar = selectAvatar;
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ColorsManager.yellow),
                    ),
                    child: Image(image: AssetImage(avatars[index])),
                  ),
                ),
              );
        },
      ),
    );
  }
}
