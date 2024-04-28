import 'package:chat_2/bloc/auth/auth_bloc.dart';
import 'package:chat_2/bloc/auth/auth_event.dart';
import 'package:chat_2/bloc/auth/auth_state.dart';
import 'package:chat_2/screens/auth_screens/register_screen.dart';
import 'package:chat_2/screens/auth_screens/widget/password_text_input.dart';
import 'package:chat_2/screens/auth_screens/widget/simple_global_button.dart';
import 'package:chat_2/screens/auth_screens/widget/universal_text_input.dart';
import 'package:chat_2/screens/contacts/contact_screen.dart';
import 'package:chat_2/utils/app_images.dart';
import 'package:chat_2/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_colors.dart';
import '../../utils/styles/app_text_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
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
            return Center(
              child: Text(state.errorText),
            );
          }
          if (state is AuthInitialState) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
              ),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 25.h,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome Back!",
                              style: AppTextStyle.rubikSemiBold.copyWith(
                                color: AppColors.c_2C2C73,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            UniversalTextField(
                              errorText: "Mailni to'g'ri  kiriting!",
                              regExp: RegExp("[a-zA-Z]"),
                              controller: emailController,
                              iconPath: AppImages.sms,
                              hintText: "Mail",
                              type: TextInputType.text,
                            ),
                            SizedBox(height: 16.h),
                            PasswordTextField(
                              controller: passwordController,
                              iconPath: AppImages.log,
                              isVisible: false,
                              suffix: GestureDetector(
                                onTap: () {},
                                child: const Text("Forgot"),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            SimpleGlobalButton(
                              onTap: () {
                                context.read<AuthBloc>().add(
                                      AuthLoginEvent(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                              },
                              title: "LOGIN",
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const RegisterScreen();
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
                            "Don’t have an account? Sign Up",
                            style: AppTextStyle.rubikSemiBold.copyWith(
                              fontSize: 14,
                              color: AppColors.c_2C2C73.withOpacity(0.8),
                            ),
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
