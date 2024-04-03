import 'package:flutter/material.dart';
import 'package:kridaverse_e_commerce/APIS/apis.dart';
import 'package:kridaverse_e_commerce/Custom%20Widgets/custom_bottom_navbar.dart';
import 'package:kridaverse_e_commerce/Custom%20Widgets/eleveted_button.dart';
import 'package:kridaverse_e_commerce/Custom%20Widgets/popup_and_loader.dart';
import 'package:kridaverse_e_commerce/Custom%20Widgets/reusable_bottom_navbar.dart';
import 'package:kridaverse_e_commerce/Custom%20Widgets/text_form_field.dart';
import 'package:kridaverse_e_commerce/Theme/appColor.dart';
import 'package:kridaverse_e_commerce/main.dart';
import 'package:kridaverse_e_commerce/screens/home_screen.dart';
import 'package:kridaverse_e_commerce/screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  // Loading Animation
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: mq.height * 1,
        width: mq.width * 1,
        color: AppColor().black,
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            height: mq.height * .6,
            width: mq.width * .9,
            decoration: BoxDecoration(
                color: AppColor().darkGrey,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //  Name Field
                ReusableTextFormField(
                  controller: _nameController,
                  fieldName: 'Name',
                  keyboardtype: TextInputType.name,
                ),

                SizedBox(
                  height: mq.height * .02,
                ),

                //  Phone No Field
                ReusableTextFormField(
                  controller: _phoneNoController,
                  fieldName: 'Phone No',
                  keyboardtype: TextInputType.number,
                ),

                SizedBox(
                  height: mq.height * .02,
                ),
                //  Email Field
                ReusableTextFormField(
                    controller: _emailController,
                    fieldName: 'Email',
                    keyboardtype: TextInputType.emailAddress),

                SizedBox(
                  height: mq.height * .02,
                ),
                //Password Field
                ReusableTextFormField(
                    controller: _passwordController,
                    fieldName: 'Password',
                    isObsecure: true,
                    keyboardtype: TextInputType.visiblePassword),
                SizedBox(
                  height: mq.height * .03,
                ),
                // Login Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: mq.width * .35,
                        height: mq.width * .11,
                        child: ReusableElevetedButton(
                            btnName: 'Login',
                            userOnpressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            })),
                    SizedBox(
                        width: mq.width * .35,
                        height: mq.width * .11,
                        child: ReusableElevetedButton(
                            btnName: 'SignUp',
                            userOnpressed: () => _signUpViaEmail())),
                  ],
                ),

                SizedBox(
                  height: mq.height * .05,
                ),

                SizedBox(
                  width: mq.width * 1,
                  height: mq.width * .11,
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor().white),
                      onPressed: () => _handleGoogleSignin(),
                      icon: Image.asset(
                        'assets/images/googleLogo.png',
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      label: Text(
                        'Sign in with google',
                        style: TextStyle(color: AppColor().black),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Email sign in Funtion
  _signUpViaEmail() {
    if (_nameController.text.isEmpty ||
        _emailController.text == "" ||
        _passwordController.text == "" ||
        _phoneNoController == "") {
      DialogsWidget.showFlushBar(context, 'Please enter all the fields');
    } else if (!_emailController.text.contains('@')) {
      DialogsWidget.showFlushBar(context, 'Invalid email');
    } else {
      DialogsWidget.showProgressBar(context, _controller);
      Apis().signUpWithEmail(
          context, _emailController.text, _passwordController.text);
    }
  }

  // Sign in with Google Function
  _handleGoogleSignin() {
    DialogsWidget.showProgressBar(context, _controller);
    Apis().signInWithGoogle().then((user) async {
      Navigator.pop(context);
      if (user != null) {
        print('User data: ${user}');
        if (await Apis.userExists()) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const ReusableBottomNavbar()));
        } else {
          await Apis.createUser().then((value) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ReusableBottomNavbar()));
          });
        }
      } else {
        DialogsWidget.showFlushBar(
            context, 'Something went wrong try again later');
      }
    });
  }
}
