import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies/core/assets_manager.dart';
import 'package:movies/core/helper/show_snack_bar.dart';
import 'package:movies/core/widgets/custom_elevation_button.dart';
import 'package:movies/core/widgets/custom_text_form_failed.dart';
import 'package:movies/feature/reset_password/presentation/view_model/reset_password_cubit.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController oldPassword = TextEditingController();

  TextEditingController newPassword = TextEditingController();

  @override
  void dispose() {
    oldPassword.dispose();
    newPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.reset_password,
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(image: AssetImage(AssetsManager.resetPassword)),
            CustomTextFormFailed(
              controller: oldPassword,
              label: "Old Password",
              prefixIconPath: AssetsManager.password,
            ),
            CustomTextFormFailed(
              controller: newPassword,
              label: "New Password",
              prefixIconPath: AssetsManager.password,
            ),
            BlocConsumer<ResetPasswordCubit ,ResetPasswordState>(
              listener: (context, state) {
                if(state is ResetPasswordFailure){
                  showSnackBar(context, state.errorMessage);
                }
                else if(state is ResetPasswordSuccess){
                  showSnackBar(context, "password updated");
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return CustomElevationButton(
isLoading: state is ResetPasswordLoading,
                  onPressed: () async {
                    await BlocProvider.of<ResetPasswordCubit>(
                      context,
                    ).resetPassword(oldPassword.text, newPassword.text);
                  },
                  txt: AppLocalizations.of(context)!.reset_password,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
