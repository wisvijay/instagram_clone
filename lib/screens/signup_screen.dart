import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../resources/auth_methods.dart';
import '../utils/color.dart';
import '../utils/constants.dart';
import '../utils/images.dart';
import '../utils/utils.dart';
import '../utils/spaces.dart';
import '../widgets/text_field_input.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool isLoading = false;
  Uint8List? image;

  signup() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().signupUser(
      userName: _usernameController.text,
      fullName: _fullnameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      bio: _bioController.text,
      file: image!,
    );

    if (res == Success) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false,
      );
    } else {
      showSnackBar(context, res);
    }
    setState(() {
      isLoading = false;
    });
  }

  selectImage() async {
    Uint8List pim = await pickImage(ImageSource.gallery);
    setState(() {
      image = pim;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _fullnameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Stack(
                children: [
                  image != null
                      ? CircleAvatar(
                          backgroundImage: MemoryImage(image!),
                          radius: 64,
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(AppImages.profileImg),
                        ),
                  Positioned(
                    right: -10,
                    bottom: -5,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo_outlined),
                    ),
                  ),
                ],
              ),
              kVerticalSpaceMedium,
              TextFieldInput(
                controller: _usernameController,
                inputType: TextInputType.text,
                hintText: userNameStr,
              ),
              kVerticalSpaceSmall,
              TextFieldInput(
                controller: _fullnameController,
                inputType: TextInputType.text,
                hintText: fullNameStr,
              ),
              kVerticalSpaceSmall,
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
              TextFieldInput(
                controller: _bioController,
                inputType: TextInputType.text,
                hintText: bioStr,
              ),
              kVerticalSpaceSmall,
              InkWell(
                onTap: signup,
                child: isLoading
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
                        child: const Text(signUpStr),
                      ),
              ),
              kVerticalSpaceLarge,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(alreadyHavingAccountStr),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text(signInStr),
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
    ;
  }
}
