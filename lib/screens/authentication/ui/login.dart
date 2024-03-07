import 'package:chat_application/component/common_textfield.dart';
import 'package:chat_application/component/primary_btn.dart';
import 'package:chat_application/constant/global.dart';
import 'package:chat_application/screens/authentication/bloc/login_bloc.dart';
import 'package:chat_application/screens/authentication/models/login_model.dart';
import 'package:chat_application/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final mobileController = TextEditingController();
  final aboutController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();
  final _registerKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginLoading || state is RegisterLoading) {
                _showLoading(context);
              }
              if (state is LoginError) {
                _showSnackBar(context, state.message);
              }
              if (state is RegisterError) {
                _showSnackBar(context, state.message);
              }
              if (state is RegisterSuccess) {
                pushAndRemove(context, screen: const HomeScreen());
              }
            },
            builder: (context, state) {
              if (state is LoginSuccess || state is RegisterLoading) {
                Navigator.maybePop(context);
                return _registerWidget(context);
              }
              return _loginWidget(context);
            },
          ),
        ),
      ),
    );
  }

  void _showLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    Navigator.maybePop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _registerWidget(BuildContext context) {
    return Form(
      key: _registerKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonTextField(
            controller: fNameController,
            hintText: "First Name",
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Please enter First Name";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          CommonTextField(
            controller: lNameController,
            hintText: "Last Name",
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Please enter Last Name";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          CommonTextField(
            controller: mobileController,
            hintText: "Mobile No.",
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Please enter Mobile No.";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          CommonTextField(
            controller: aboutController,
            hintText: "Something about you...",
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            onTap: () => _onRegister(context),
            text: "Get Started",
          )
        ],
      ),
    );
  }

  void _onRegister(BuildContext context) {
    if (isRegisterValidate) {
      final loginModel = LoginModel(
        about: aboutController.text.trim(),
        firstName: fNameController.text.trim(),
        lastName: fNameController.text.trim(),
        mobile: mobileController.text.trim(),
        uuid: FirebaseAuth.instance.currentUser!.uid,
        email: emailController.text.trim(),
      );
      context.read<LoginBloc>().add(RegisterLoadingEvent(loginModel));
    }
  }

  Widget _loginWidget(BuildContext context) {
    return Form(
      key: _loginKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonTextField(
            controller: emailController,
            hintText: "Enter you email",
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Please enter your email";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CommonTextField(
            controller: passwordController,
            hintText: "Enter your password",
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Please enter password";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            onTap: () => _onLogin(context),
            text: "Login",
          )
        ],
      ),
    );
  }

  void _onLogin(BuildContext context) {
    if (isLoginValidate) {
      context.read<LoginBloc>().add(
            LoginLoadingEvent(
              email: emailController.text,
              password: passwordController.text,
            ),
          );
    }
  }

  bool get isLoginValidate => _loginKey.currentState!.validate();

  bool get isRegisterValidate => _registerKey.currentState!.validate();
}
