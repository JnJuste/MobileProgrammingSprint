import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:navigation_bar/screens/login/authPage.dart';
import 'package:navigation_bar/utils/constants.dart';
import 'package:navigation_bar/views/quizCategory.dart';

// ignore: must_be_immutable
class WelcomeScreen extends StatelessWidget {
  TextEditingController userNameController = TextEditingController();
  WelcomeScreen({super.key});

  Future<void> navigateToAdminLogin() async {
    Get.to(() => const AuthPage()); // Navigate to the admin login page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        SvgPicture.asset(
          "assets/bg.svg",
          fit: BoxFit.fitWidth,
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(
                  flex: 2,
                ),
                Text(
                  "Welcome to the Student Quiz Platform",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const Text(
                  "Enter your student information below",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const Spacer(), // /1/6
                TextField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFC1C1C1),
                    hintText: "Full Name and ID (NAMES-ID)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.to(const QuizCategoryScreen());
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(kDefaultPadding * 0.75),
                    decoration: const BoxDecoration(
                      gradient: kPrimaryGradient,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Let's Start Quiz",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),

                const SizedBox(height: 20), // Added SizedBox for spacing
                GestureDetector(
                  onTap:
                      navigateToAdminLogin, // Call the function to navigate to the admin page
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(kDefaultPadding * 0.75),
                    decoration: const BoxDecoration(
                      color: Colors.white, // Changed color to white
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Admin Login Page", // Changed text to "Admin Page"
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),

                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
