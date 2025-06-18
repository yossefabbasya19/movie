import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/assets_manager.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/helper/show_snack_bar.dart';
import 'package:movies/core/my_routes/my_routes.dart';
import 'package:movies/core/shared_pref/shared_pref.dart';
import 'package:movies/core/validation_rules/validation_rules.dart';
import 'package:movies/core/widgets/custom_elevation_button.dart';
import 'package:movies/core/widgets/custom_text_button.dart';
import 'package:movies/core/widgets/custom_text_form_failed.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies/core/widgets/custom_toggle_switch.dart';
import 'package:movies/core/widgets/custom_widget_display_two_text.dart';
import 'package:movies/feature/authentication/presentation/views_model/login_cubit/login_cubit.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    SharedPref().onBoardingIsAlreadyOpen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Image(image: AssetImage(AssetsManager.appLogo)),
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
              CustomTextButton(
                onPressed: () {},
                textTwo: AppLocalizations.of(context)!.forget_password,
              ),
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginFailure) {
                    showSnackBar(context, state.errMessage);
                  } else if (state is LoginSuccess) {
                    Navigator.pushReplacementNamed(context,MyRoutes.mainLayout);
                  }
                },
                builder: (context, state) {
                  return CustomElevationButton(
                    isLoading: state is LoginLoading,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await BlocProvider.of<LoginCubit>(
                          context,
                        ).login(emailController.text, passwordController.text);

                      }
                    },
                    txt: AppLocalizations.of(context)!.login,
                  );
                },
              ),
              SizedBox(height: 8),
              CustomWidgetDisplayTwoText(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, MyRoutes.register);
                },
                textOne: AppLocalizations.of(context)!.do_not_have_account,
                textTwo: AppLocalizations.of(context)!.create_one,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: ColorsManager.yellow,
                    height: height * 0.002,
                    width: width * 0.3,
                  ),
                  SizedBox(width: width * 0.04),
                  Text("or", style: Theme.of(context).textTheme.titleSmall),
                  SizedBox(width: width * 0.04),
                  Container(
                    color: ColorsManager.yellow,
                    height: height * 0.002,
                    width: width * 0.3,
                  ),
                ],
              ),
              SizedBox(height: 8),
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if(state is LoginWithGoogleFailure ){
                    showSnackBar(context,state.errMessage);
                  }else if(state is LoginWithGoogleSuccess){
                  }
                },
                builder: (context, state) {
                  return CustomElevationButton(
                    isLoading: state is LoginWithGoogleLoading,
                    onPressed: () async {
                      await BlocProvider.of<LoginCubit>(
                        context,
                      ).signInWithGoogle(context);

                    },
                    txt: AppLocalizations.of(context)!.login_with_google,
                  );
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
