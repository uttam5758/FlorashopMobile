import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cybershop/models/userModel.dart';
import 'package:cybershop/repository/userRepository.dart';
import 'package:cybershop/screens/animation.dart';
import 'package:cybershop/screens/navigation_screen.dart';
import 'package:cybershop/screens/signout.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  _navigateToScreen(bool isLogin) {
    if (isLogin) {
      // MotionToast.success(description: const Text('success login'))
      //     .show(context);
      AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          // This is just a basic example. For real apps, you must show some
          // friendly dialog box before call the request method.
          // This is very important to not harm the user experience
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 1,
              channelKey: 'basic_channel',
              title: 'Sign in',
              body: "Welcome to Flora Shop"));
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return NavigationDrawers();
      }), (Route<dynamic> route) => false);
    } else {
      MotionToast.error(
              description: const Text("Either email or password is incorrect"))
          .show(context);
    }
  }

  _loginUser(User user) async {
    try {
      UserRepository userRepository = UserRepository();

      bool isLogin = await userRepository.loginUser(user);

      if (isLogin) {
        _navigateToScreen(true);
      } else {
        _navigateToScreen(false);
      }
    } catch (e) {
      MotionToast.error(
        description: Text("Error:${e.toString()}"),
      ).show(context);
    }
  }

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String? email;
  String? password;

  @override
  void initState() {
    super.initState();

    autoLogin();
  }

  void autoLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString('token');

    // print(token);

    if (token != null && token.isNotEmpty) {
      _navigateToScreen(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 40.0),
                AnimationWidget(
                  axis: Axis.vertical,
                  curve: Curves.easeOutExpo,
                  offset: 100.0,
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    "Florashop 🌹",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 241, 23, 23),
                      fontSize: 32.0,
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                AnimationWidget(
                  axis: Axis.vertical,
                  curve: Curves.easeOutExpo,
                  offset: 100.0,
                  duration: const Duration(milliseconds: 1000),
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
                            "Login your account",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 18, 56, 120),
                              fontSize: 17.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        key: ValueKey('txtEmail'),
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
                        key: ValueKey('txtPassword'),
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
                      AnimationWidget(
                        axis: Axis.vertical,
                        curve: Curves.easeOutExpo,
                        offset: 100.0,
                        duration: const Duration(milliseconds: 2000),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Forgot Password? : "),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignOut(),
                                    ));
                              },
                              child: const Text(
                                "Reset Password",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      ElevatedButton(
                        key: ValueKey('btnLogin'),
                        onPressed: () {
                          User user = User(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          _loginUser(user);
                        },
                        child: Container(
                          height: myHeight * 0.08,
                          width: myWidth,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: const Center(
                            child: Text(
                              "Sign In",
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
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    orSignIn("assets/image/google.png", 1200),
                    orSignIn("assets/image/facebook.png", 1400),
                    // orSignIn("assets/image/twitter.png", 1600),
                    orSignIn("assets/image/instagram.png", 1800),
                  ],
                ),
                const SizedBox(height: 40.0),
                AnimationWidget(
                  axis: Axis.vertical,
                  curve: Curves.easeOutExpo,
                  offset: 100.0,
                  duration: const Duration(milliseconds: 2000),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Dont have an account? : "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignOut(),
                              ));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(),
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
