import 'package:flutter/material.dart';
import '../../utils/size_utils.dart';
import '../auth_screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
  }

  @override
  void initState() {
    _init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return const Scaffold(
      body: Center(
        child: Icon(
          Icons.access_time_filled_outlined,
          color: Colors.green,
          size: 200,
        ),
      ),
    );
  }
}
