import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import '../../data/api_service.dart';
import '../../utils/constanst/constants.dart';
import '../../utils/icons/icons.dart';
import '../../utils/style/style.dart';
import '../../widgets/global_buttons.dart';
import 'widgets/auth_buttons.dart';
import 'widgets/sign_google_button.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  final ApiService apiService = ApiService();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        backgroundColor: Colors.white,
        title:const Text("Sign in", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            Lottie.asset(
              UzchatIcons.sign,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Welcome Back to Messanger",
                style: UzchatStyle.w500.copyWith(
                  fontSize: 30.0,
                  color: Colors.green.
                  withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            AuthFields(
              controller: emailController,
              hintText: 'Email', keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next, prefixIcon: Icons.email, caption: '',
            ),
            const SizedBox(height: 10),
            AuthFields(
              controller: passWordController,
              hintText: 'Password', keyboardType: TextInputType.visiblePassword, textInputAction: TextInputAction.done, prefixIcon: Icons.key, caption: '',
            ),
            const SizedBox(
              height: 10.0,
            ),
            GlobalButton(
              buttonText: 'Sign In',
              color: Colors.green,
              onTap: () async {
                await signIn(
                  email: emailController.text,
                  password: passWordController.text,
                  context: context,
                ).then(
                  (value) => Navigator.pushReplacementNamed(
                      context, Constants.selectChatScreen),
                );
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(
                  context, Constants.signUpScreen),
              child: const Text("Don't have an account?",style: TextStyle(color: Colors.red),),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SignGoogleButton(apiService: apiService)
          ],
        ),
      ),
    );
  }

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
      throw Exception();
    }
  }
}
