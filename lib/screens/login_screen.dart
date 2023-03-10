import 'package:flutter/material.dart';

import '../resources/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/color.dart';
import '../utils/constants.dart';
import '../utils/images.dart';
import '../utils/spaces.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  login() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods()
        .loginUser(_emailController.text, _passwordController.text);

    if (res == Success) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayoutScreen(
              weblayout: WebScreenLayout(),
              mobilelayout: MobileScreenLayout(),
            ),
          ),
          (route) => false);
    } else {
      showSnackBar(context, res);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: kScreenWidth(context) > appLayoutMobileWidth
              ? EdgeInsets.symmetric(horizontal: kScreenWidth(context) / 3)
              : const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              AppImages.getLogo(64),
              kVerticalSpaceLarge,
              TextFieldInput(
                controller: _emailController,
                inputType: TextInputType.emailAddress,
                hintText: emailAddressStr,
              ),
              kVerticalSpaceSmall,
              TextFieldInput(
                controller: _passwordController,
                inputType: TextInputType.text,
                hintText: passwordStr,
                isPass: true,
              ),
              kVerticalSpaceSmall,
              InkWell(
                onTap: login,
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: primaryColor,
                      )
                    : Container(
                        width: double.infinity,
                        height: 32,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          color: blueColor,
                        ),
                        child: const Text(loginStr),
                      ),
              ),
              kVerticalSpaceLarge,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(haveAccountStr),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const SignupScreen()),
                      );
                    },
                    child: const Text(signUpStr),
                  ),
                ],
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
