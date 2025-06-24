import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies/core/assets_manager.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/constace.dart';
import 'package:movies/core/helper/show_snack_bar.dart';
import 'package:movies/core/models/user_Dm.dart';
import 'package:movies/core/my_routes/my_routes.dart';
import 'package:movies/core/validation_rules/validation_rules.dart';
import 'package:movies/core/widgets/custom_elevation_button.dart';
import 'package:movies/core/widgets/custom_text_form_failed.dart';
import 'package:movies/feature/edit_profile/presentation/view_model/edit_profile_cubit.dart';
import 'package:movies/feature/edit_profile/presentation/views/widgets/custom_grid_view.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  int? selectAvatar;

  bool updateLoading = false;
  bool deleteLoading = false;

  @override
  void initState() {
    userNameController.text = UserDm.currentUser!.userName;
    phoneNumberController.text = BlocProvider.of<EditProfileCubit>(
      context,
    ).formatPhoneNumber(UserDm.currentUser!.phoneNumber);
    selectAvatar = BlocProvider.of<EditProfileCubit>(context).selectAvatar;
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    EditProfileCubit cubit = BlocProvider.of<EditProfileCubit>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.pick_avatar),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: BlocProvider.of<EditProfileCubit>(context).formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: height * 0.04),
                GestureDetector(
                  onTap: () async {
                    await showModalBottomSheet(
                      backgroundColor: ColorsManager.blackWithOp,
                      context: context,
                      builder: (context) {
                        return CustomGridView(
                          cubit: cubit,
                          selectAvatar: selectAvatar!,
                        );
                      },
                    );
                    selectAvatar =
                        BlocProvider.of<EditProfileCubit>(context).selectAvatar;
                  },
                  child: Image(
                    height: height * 0.2,
                    image: AssetImage(avatars[UserDm.currentUser!.avatar]),
                  ),
                ),
                CustomTextFormFailed(
                  label: "userName",
                  prefixIconPath: AssetsManager.userNameIcon,
                  controller: userNameController,
                ),
                CustomTextFormFailed(
                  validator: ValidationRules.phoneValidation,
                  label: "phone number",
                  prefixIconPath: AssetsManager.phone,
                  controller: phoneNumberController,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        MyRoutes.resetPassword,
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.reset_password,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.17),
                BlocConsumer<EditProfileCubit, EditProfileState>(
                  listener: (context, state) {
                    if (state is DeleteAccountFailure) {
                      deleteLoading = false;
                      showSnackBar(context, state.errMessage);
                    } else if (state is DeleteAccountSuccess) {
                      deleteLoading = false;
                      showSnackBar(context, "account deleted");
                      Navigator.pushReplacementNamed(context, MyRoutes.login);
                    } else if (state is DeleteAccountLoading) {
                      deleteLoading = true;
                    }
                  },
                  builder: (context, state) {
                    return CustomElevationButton(
                      isLoading: deleteLoading,
                      buttonColor: ColorsManager.red,
                      textColor: ColorsManager.white,
                      onPressed: () {
                        BlocProvider.of<EditProfileCubit>(
                          context,
                        ).deleteAccount(UserDm.currentUser!.userID);
                      },
                      txt: AppLocalizations.of(context)!.delete_account,
                    );
                  },
                ),
                BlocConsumer<EditProfileCubit, EditProfileState>(
                  listener: (context, state) {
                    if (state is UpdateDataFailure) {
                      updateLoading = false;
                      showSnackBar(context, state.errMessage);
                    } else if (state is UpdateDataSuccess) {
                      updateLoading = false;
                      showSnackBar(context, "data updated");
                      Navigator.pop(context);
                    } else if (state is UpdateDataLoading) {
                      updateLoading = true;
                    }
                  },
                  builder: (context, state) {
                    return CustomElevationButton(
                      isLoading: updateLoading,
                      onPressed: () async {
                        var userInfo = UserDm(
                          userID: UserDm.currentUser!.userID,
                          avatar: selectAvatar!,
                          userName: userNameController.text,
                          email: UserDm.currentUser!.email,
                          phoneNumber: phoneNumberController.text,
                          watchList: UserDm.currentUser!.watchList,
                          history: UserDm.currentUser!.history,
                        );
                        await BlocProvider.of<EditProfileCubit>(
                          context,
                        ).updateData(userInfo);
                      },
                      txt: AppLocalizations.of(context)!.update_data,
                    );
                  },
                ),
                SizedBox(height: height * 0.01),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
