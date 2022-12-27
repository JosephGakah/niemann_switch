import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final primaryLightColor = const Color(0xFFD8EBED);
  final primaryDarkColor = const Color(0xFF2E3243);

  bool isPressed = false;
  bool isDark = false;

  Widget DayNight() {
    final positionedShadow = isDark ? -40.0 : -210.0;

    return Stack(
      children: [
        Container(
          width: 210,
          height: 210,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: isDark
                      ? [const Color(0xFF38218F), const Color(0xFF8081DD)]
                      : [const Color(0xFFFFCC81), const Color(0xFFFF6e30)])),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          top: positionedShadow,
          right: positionedShadow,
          child: Container(
            width: 210,
            height: 210,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? primaryDarkColor : primaryLightColor),
          ),
        ),
      ],
    );
  }

  Widget CenterText() {
    return Text(isDark ? 'Good\nNight' : 'Good\nMorning',
        style: GoogleFonts.signikaNegative(
            fontSize: 44, fontWeight: FontWeight.bold));
  }

  Widget PowerButton() {
    return Listener(
        onPointerDown: (_) => setState(() {
              isPressed = true;
            }),
        onPointerUp: (_) => setState(() {
              isPressed = false;
              isDark = !isDark;

              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                  statusBarBrightness:
                      isDark ? Brightness.dark : Brightness.light));
            }),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: 140,
          height: 140,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? primaryDarkColor : primaryLightColor,
              boxShadow: [
                BoxShadow(
                    offset: const Offset(-5, 5),
                    blurRadius: 10,
                    color: isDark
                        ? const Color(0xFF121625)
                        : const Color(0XFFA5B786),
                    inset: isPressed),
                BoxShadow(
                    offset: const Offset(-5, 5),
                    blurRadius: 10,
                    color: isDark ? const Color(0x4D9DA7CF) : Colors.white,
                    inset: isPressed),
              ]),
          child: Icon(
            Icons.power_settings_new,
            size: 48,
            color: isDark ? primaryLightColor : primaryDarkColor,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? primaryDarkColor : primaryLightColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DayNight(),
            const SizedBox(height: 36),
            CenterText(),
            const SizedBox(height: 146),
            PowerButton()
          ],
        ),
      ),
    );
  }
}
