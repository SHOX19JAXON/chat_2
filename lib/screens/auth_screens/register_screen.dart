import 'package:chat_2/bloc/auth/auth_bloc.dart';
import 'package:chat_2/bloc/auth/auth_event.dart';
import 'package:chat_2/bloc/auth/auth_state.dart';
import 'package:chat_2/screens/auth_screens/widget/password_text_input.dart';
import 'package:chat_2/screens/auth_screens/widget/simple_global_button.dart';
import 'package:chat_2/screens/auth_screens/widget/universal_text_input.dart';
import 'package:chat_2/screens/contacts/contact_screen.dart';
import 'package:chat_2/utils/app_colors.dart';
import 'package:chat_2/utils/app_images.dart';
import 'package:chat_2/utils/constants/app_constant.dart';
import 'package:chat_2/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/styles/app_text_style.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool passwordVisibility = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthErrorState) {
            return Center(child: Text(state.errorText));
          }
          if (state is AuthInitialState) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 25.h,
                            ),
                            Text(
                              "Create your account!",
                              style: AppTextStyle.rubikBold.copyWith(
                                color: AppColors.c_2C2C73,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            UniversalTextField(
                              labelText: "Your name",
                              errorText: "Ismni to'g'ri  kiriting!",
                              regExp: AppConstants.textRegExp,
                              controller: usernameController,
                              iconPath: AppImages.sms,
                              hintText: "Your Name",
                              type: TextInputType.text,
                            ),
                            SizedBox(height: 8.h),
                            UniversalTextField(
                              errorText: "Emailni to'g'ri  kiriting!",
                              regExp: AppConstants.emailRegExp,
                              controller: emailController,
                              iconPath: "",
                              hintText: "Email",
                              type: TextInputType.emailAddress,
                            ),
                            PasswordTextField(
                              controller: passwordController,
                              iconPath: "",
                              isVisible: passwordVisibility,
                              suffix: IconButton(
                                onPressed: () {
                                  passwordVisibility = !passwordVisibility;
                                  setState(() {});
                                },
                                icon: Icon(
                                  passwordVisibility
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                splashRadius: 20,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            SimpleGlobalButton(
                              onTap: () {
                                context.read<AuthBloc>().add(
                                      AuthRegisterEvent(
                                        name: usernameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                              },
                              title: "REGISTER",
                              horizontalPadding: 0,
                              verticalPadding: 0,
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Row(
                              children: [
                                const Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(AppImages.google),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(AppImages.fasebook),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(AppImages.iphone),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const LoginScreen();
                            },
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            size: 12,
                            color: AppColors.c_29BB89.withOpacity(0.45),
                          ),
                          SizedBox(width: 8.h),
                          Text(
                            "Already have an account? Login",
                            style: AppTextStyle.rubikSemiBold.copyWith(
                                fontSize: 14, color: AppColors.c_2C2C73),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        listener: (BuildContext context, AuthState state) {
          if (state is AuthSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ContactScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}
