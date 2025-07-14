import 'package:cybershop/models/userModel.dart';
import 'package:cybershop/repository/userRepository.dart';
import 'package:cybershop/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

import 'animation.dart';

class SignOut extends StatefulWidget {
  const SignOut({Key? key}) : super(key: key);

  @override
  State<SignOut> createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? username;
  String? email;
  String? password;
  String? confirmPassword;

  _registerUser(User user) async {
    bool isLogin = await UserRepository().registerUser(user);
    if (isLogin) {
      Navigator.popAndPushNamed(context, '/signin');
      _displayMessage(true);
    } else {
      _displayMessage(false);
    }
  }

  _displayMessage(msg) {
    if (msg) {
      MotionToast.success(description: const Text('success register'))
          .show(context);
    } else {
      MotionToast.warning(description: const Text('error rergister'))
          .show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 900,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                SizedBox(
                  height: myHeight * 0.07,
                  width: myWidth,
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignIn(),
                                ));
                          },
                          child: const Icon(Icons.arrow_back_ios_new_rounded)),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        AnimationWidget(
                          axis: Axis.vertical,
                          curve: Curves.easeOutExpo,
                          offset: 100.0,
                          duration: const Duration(milliseconds: 800),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "Florashop 🌹",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 241, 23, 23),
                                fontSize: 32.0,
                              ),
                            ),
                          ),
                        ),
                        AnimationWidget(
                          axis: Axis.vertical,
                          curve: Curves.easeOutExpo,
                          offset: 100.0,
                          duration: const Duration(milliseconds: 1000),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      "Welcome,",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 18, 56, 120),
                                        fontSize: 22.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      "Create your account",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 18, 56, 120),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                TextFormField(
                                  key: const ValueKey('txtName'),
                                  controller: nameController,
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    setState(() {
                                      username = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Name",
                                      suffixIcon: Icon(Icons.person_outline),
                                      border: OutlineInputBorder()),
                                ),
                                const SizedBox(height: 10.0),
                                TextFormField(
                                  key: const ValueKey('txtEmail'),
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    setState(() {
                                      email = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Email",
                                      suffixIcon: Icon(Icons.email),
                                      border: OutlineInputBorder()),
                                ),
                                const SizedBox(height: 10.0),
                                TextFormField(
                                  key: const ValueKey('txtPassword'),
                                  controller: passwordController,
                                  keyboardType: TextInputType.number,
                                  obscureText: true,
                                  onChanged: (value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Password",
                                      suffixIcon: Icon(Icons.lock),
                                      border: OutlineInputBorder()),
                                ),
                                const SizedBox(height: 10.0),
                                TextFormField(
                                  key: const ValueKey('txtConfirmPassword'),
                                  controller: confirmPasswordController,
                                  keyboardType: TextInputType.number,
                                  obscureText: true,
                                  onChanged: (value) {
                                    setState(() {
                                      confirmPassword = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Confirm Password",
                                      suffixIcon: Icon(Icons.lock),
                                      border: OutlineInputBorder()),
                                ),
                                const SizedBox(height: 40.0),
                                ElevatedButton(
                                  key: const ValueKey('btnRegister'),
                                  onPressed: () {
                                    User user = User(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                    _registerUser(user);
                                  },
                                  child: Container(
                                    height: myHeight * 0.08,
                                    width: myWidth,
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: const Center(
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            orSignIn("assets/image/google.png", 1200),
                            orSignIn("assets/image/facebook.png", 1400),
                            orSignIn("assets/image/twitter.png", 1600),
                            orSignIn("assets/image/instagram.png", 1800),
                          ],
                        ),
                        const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget orSignIn(String image, int duration) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return AnimationWidget(
      axis: Axis.vertical,
      curve: Curves.easeOutExpo,
      offset: 100.0,
      duration: Duration(milliseconds: duration),
      child: Container(
        height: myHeight * 0.08,
        width: myWidth * 0.16,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5.0)),
        child: Center(
          child: Image.asset(image, height: 30.0),
        ),
      ),
    );
  }
}
