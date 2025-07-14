import 'package:cybershop/repository/userRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:motion_toast/motion_toast.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  void _changePasswordUrl() async {
    try {
      UserRepository userRepository = UserRepository();

      bool isLogin = await userRepository.changePassword(
          oldPassword.text, newPassword.text, confirmPassword.text);
      if (isLogin == true) {
        print("password changed");
      } else {
        print("password not changed");
      }
    } catch (e) {
      MotionToast.error(
        description: Text("Error:${e.toString()}"),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          TextField(
            controller: oldPassword,
            decoration: InputDecoration(
              hintText: 'Old Password',
            ),
          ),
          TextField(
            controller: newPassword,
            decoration: InputDecoration(
              hintText: 'New Password',
            ),
          ),
          TextField(
            controller: confirmPassword,
            decoration: InputDecoration(
              hintText: 'Confirm Password',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                UserRepository userRepository = UserRepository();

                bool isLogin = await userRepository.changePassword(
                    oldPassword.text, newPassword.text, confirmPassword.text);
                if (isLogin == true) {
                  print("password changed");
                } else {
                  print("password not changed");
                }
              } catch (e) {
                MotionToast.error(
                  description: Text("Error:${e.toString()}"),
                ).show(context);
              }
            },
            child: const Text('Change Password'),
          ),
        ]),
      ),
    );
  }
}
