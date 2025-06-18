import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/assets_manager.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/constace.dart';
import 'package:movies/core/helper/show_snack_bar.dart';
import 'package:movies/core/models/user_Dm.dart';
import 'package:movies/core/my_routes/my_routes.dart';
import 'package:movies/core/validation_rules/validation_rules.dart';
import 'package:movies/core/widgets/custom_carousel_slider.dart';
import 'package:movies/core/widgets/custom_elevation_button.dart';
import 'package:movies/core/widgets/custom_text_form_failed.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies/core/widgets/custom_toggle_switch.dart';
import 'package:movies/core/widgets/custom_widget_display_two_text.dart';
import 'package:movies/feature/authentication/presentation/views_model/create_account_cubit/create_account_cubit.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> formKey = GlobalKey();
  String avatarName = avatars[0];
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //double height = MediaQuery.sizeOf(context).height;
    //double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorsManager.black,
        title: Text(
          AppLocalizations.of(context)!.register,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomCarouselSlider(
                onPageChanged: (index, _) {
                  avatarName = avatars[index];
                },
              ),
              SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.avatar,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 16),
              ),
              CustomTextFormFailed(
                validator: ValidationRules.titleValidation,
                controller: nameController,
                label: AppLocalizations.of(context)!.name,
                prefixIconPath: AssetsManager.id,
              ),
              CustomTextFormFailed(
                validator: ValidationRules.emailValidate,
                controller: emailController,
                label: AppLocalizations.of(context)!.email,
                prefixIconPath: AssetsManager.email,
              ),
              CustomTextFormFailed(
                validator: ValidationRules.passwordValidate,
                isPassword: true,
                controller: passwordController,
                label: AppLocalizations.of(context)!.password,
                prefixIconPath: AssetsManager.password,
              ),
              CustomTextFormFailed(
                validator: (p0) {
                  if (p0 != passwordController.text) {
                    return "password not match";
                  }
                  return null;
                },
                isPassword: true,
                label: AppLocalizations.of(context)!.confirm_password,
                prefixIconPath: AssetsManager.password,
              ),
              CustomTextFormFailed(
                controller: phoneController,
                validator: ValidationRules.phoneValidation,
                label: AppLocalizations.of(context)!.phone,
                prefixIconPath: AssetsManager.phone,
              ),
              BlocConsumer<CreateAccountCubit, CreateAccountState>(
                listener: (context, state) {
                  if (state is CreateAccountFailure) {
                    showSnackBar(context, state.errMessage);
                  } else if (state is CreateAccountSuccess) {}
                },
                builder: (context, state) {
                  return CustomElevationButton(
                    isLoading: state is CreateAccountLoading,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<CreateAccountCubit>(
                          context,
                        ).createAccount(
                          UserDm(
                            userID: '',
                            avatar: avatarName,
                            userName: nameController.text,
                            email: emailController.text,
                            phoneNumber: phoneController.text,
                            watchList: [],
                            history: [],
                          ),
                          passwordController.text,
                        );
                      }
                    },
                    txt: AppLocalizations.of(context)!.create_account,
                  );
                },
              ),
              SizedBox(height: 8),
              CustomWidgetDisplayTwoText(
                textOne: AppLocalizations.of(context)!.already_have_account,
                textTwo: AppLocalizations.of(context)!.login,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, MyRoutes.login);
                },
              ),
              SizedBox(height: 16),
              CustomToggleSwitch(),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
