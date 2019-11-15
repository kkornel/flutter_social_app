import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_app/components/rounded_button.dart';
import 'package:flutter_social_app/screens/login_screen.dart';
import 'package:flutter_social_app/screens/registration_screen.dart';
import 'package:flutter_social_app/utils/constants.dart';
import 'package:flutter_social_app/utils/constants_strings.dart' as STRINGS;

class WelcomeScreen extends StatefulWidget {
  static String id = "welcome_screen";

  WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Animation backgroundAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this, // Possible because of TickerProviderStateMixin
    );

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    );

    controller.forward();

    backgroundAnimation =
        ColorTween(begin: Colors.red, end: Colors.green).animate(controller);

    // controller.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1);
    //     print(status);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });

    // We have to set thi up in order to animate Hero Image
    controller.addListener(() {
      setState(() {});
      // print(controller.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundAnimation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: kHeroTagLogo,
                  child: Container(
                    height: animation.value * 100,
                    child: Image.asset(kImageMainLogo),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // SizedBox(width: 20.0, height: 100.0),
                    Text(
                      "Be",
                      style: TextStyle(fontSize: 43.0),
                    ),
                    SizedBox(width: 20.0, height: 100.0),
                    RotateAnimatedTextKit(
                        onTap: () {
                          print("Tap Event");
                        },
                        text: ["AWESOME", "OPTIMISTIC", "DIFFERENT"],
                        textStyle:
                            TextStyle(fontSize: 40.0, fontFamily: "Horizon"),
                        textAlign: TextAlign.start,
                        alignment: AlignmentDirectional
                            .topStart // or Alignment.topLeft
                        ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              text: STRINGS.LOGIN,
              color: Colors.red,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              text: STRINGS.REGISTER,
              color: Colors.teal,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
