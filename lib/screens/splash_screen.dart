import 'package:cartzilla/constants/app_colors.dart';
import 'package:cartzilla/responsive/device_dimensions.dart';
import 'package:cartzilla/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Hide status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: DeviceDimensions.screenHeight(context) * 0.020),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.asset(
                  'assets/images/splash-image.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: DeviceDimensions.screenHeight(context) * 0.010),
              Text(
                'Find The\nBest Collections',
                style: GoogleFonts.inter(
                  fontSize: DeviceDimensions.responsiveSize(context) * 0.090,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),

              Text(
                'Get your dream item easily with FashionHub and get other intersting offer',
                style: GoogleFonts.inter(fontSize: 14, color: Colors.black54),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal:
                            DeviceDimensions.screenWidth(context) * 0.125,
                      ),
                      side: const BorderSide(color: Colors.black12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Sign up',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal:
                            DeviceDimensions.screenWidth(context) * 0.125,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Sign in',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: DeviceDimensions.screenHeight(context) * 0.030),
            ],
          ),
        ),
      ),
    );
  }
}
