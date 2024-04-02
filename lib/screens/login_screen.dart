import 'package:flutter/material.dart';
import 'package:kridaverse_e_commerce/APIS/apis.dart';
import 'package:kridaverse_e_commerce/Custom%20Widgets/eleveted_button.dart';
import 'package:kridaverse_e_commerce/Custom%20Widgets/popup_and_loader.dart';
import 'package:kridaverse_e_commerce/Custom%20Widgets/text_form_field.dart';
import 'package:kridaverse_e_commerce/Theme/appColor.dart';
import 'package:kridaverse_e_commerce/main.dart';
import 'package:kridaverse_e_commerce/screens/home_screen.dart';
import 'package:kridaverse_e_commerce/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  TextEditingController _emailController = TextEditingController();
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
            height: mq.height * .4,
            width: mq.width * .9,
            decoration: BoxDecoration(
                color: AppColor().darkGrey,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //  Email Field
                ReusableTextFormField(
                    controller: _emailController, fieldName: 'Email', keyboardtype: TextInputType.emailAddress,),

                SizedBox(
                  height: mq.height * .02,
                ),
                //Password Field
                ReusableTextFormField(
                  controller: _passwordController,
                  fieldName: 'Password',
                  isObsecure: true, keyboardtype: TextInputType.visiblePassword,
                ),
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
                            btnName: 'SignUp',
                            userOnpressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen()));
                            })),
                    SizedBox(
                        width: mq.width * .35,
                        height: mq.width * .11,
                        child: ReusableElevetedButton(
                            btnName: 'Login',
                            userOnpressed: () => _signinViaEmail())),
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

  // Sign in with Email Function
  _signinViaEmail() {
    if (_emailController.text == "" || _passwordController.text == "") {
      DialogsWidget.showFlushBar(context, 'Please enter all the fields');
    } else if (!_emailController.text.contains('@')) {
      DialogsWidget.showFlushBar(context, 'Invalid email');
    } else {
      DialogsWidget.showProgressBar(context, _controller);
      Apis().signInWithEmail(
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
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else {
          await Apis.createUser().then((value) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          });
        }
      } else {
        DialogsWidget.showFlushBar(
            context, 'Something went wrong try again later');
      }
    });
  }
}
