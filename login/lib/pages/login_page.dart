import 'package:flutter/material.dart';
import 'package:login/components/ProgressIndicatorWidget.dart';
import 'package:login/providers/ProgressListener.dart';
import 'package:login/providers/PwdToggleListener.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController(),
      _pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProgressListener>(
        builder: (BuildContext context, value, Widget? child) => IgnorePointer(
          ignoring: value.isLoading,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Input("User Name", _emailController),
                        Input("Password", _pwdController,
                            isObscure: true,
                            enableSuffix: true,
                            inputAction: TextInputAction.done),
                        Builder(
                          builder: (BuildContext context) => Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: value.isLoading
                                ? const Center(child: ProgressIndicatorWidget())
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blueAccent,
                                      onPrimary: Colors.white,
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width,
                                          50),
                                    ),
                                    onPressed: () {
                                      if (_isValid(context, value)) {
                                        value.isProgressLoading(true);
                                        Future.delayed(
                                                const Duration(seconds: 2))
                                            .then((value) =>
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const HomePage(),
                                                    )));
                                      }
                                    },
                                    child: const Text("LOGIN",
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const TextWidget(
                  //   forgetPwd,
                  //   color: onPrimaryBgLight,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isValid(BuildContext context, ProgressListener providerClassListen) {
    if (_emailController.text.isEmpty || _pwdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_emailController.text.isEmpty
              ? 'User name is empty'
              : 'Password is empty')));
      return false;
    } else if (_emailController.text != 'testuser' &&
        _pwdController.text != 'test123') {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter valid user name and password')));
      return false;
    }
    return true;
  }
}

class Input extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final TextInputAction inputAction;
  final bool isObscure, enableSuffix;

  const Input(this.text, this.controller,
      {this.inputAction = TextInputAction.next,
      this.isObscure = false,
      this.enableSuffix = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<PwdToggleListener>(
      builder: (BuildContext context, value, Widget? child) => Padding(
        padding: EdgeInsets.only(top: 12),
        child: TextFormField(
          style: const TextStyle(color: Colors.black),
          textInputAction: inputAction,
          obscureText: isObscure && value.obscureText,
          cursorColor: Colors.blueAccent,
          controller: controller,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            suffixIcon: enableSuffix
                ? IconButton(
                    icon: Icon(
                      value.iconData,
                      color: Colors.blueAccent,
                    ),
                    onPressed: !isObscure
                        ? null
                        : () {
                            value.toggle();
                          },
                  )
                : null,
            labelText: text,
            labelStyle: const TextStyle(color: Colors.blueAccent, fontSize: 14),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent),
            ),
          ),
        ),
      ),
    );
  }
}
