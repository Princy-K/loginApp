import 'package:flutter/material.dart';
import 'package:login/pages/login_page.dart';
import 'package:login/providers/ProgressListener.dart';
import 'package:login/providers/PwdToggleListener.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<PwdToggleListener>(
            create: (context) => PwdToggleListener()),
        ListenableProvider<ProgressListener>(
            create: (context) => ProgressListener()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  LoginPage(),
      ),
    );
  }
}


