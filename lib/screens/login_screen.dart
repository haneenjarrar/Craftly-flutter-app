import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/utils/validators.dart';
import 'package:flutter_application_1/utils/error_handling.dart';
import 'package:flutter_application_1/utils/app_styles.dart';
import 'package:flutter_application_1/utils/widgets_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}
/* login screen i used stateful widget and text editing controllers to manage user input and form to validate the input
connected it to firebase authentication */
class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
   /* REMEMBER: dispose function cleans memory of form when using controllers */
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
   /* basically checking if the form is valid before attempting to log in and mounted is if
   the widget is still alive  */
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
     /*checks if there is an error or not and returns true */
    try {
      await AuthService().signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        WidgetsHelper.showSnackBar(
          context,
          ErrorHandling.getAuthErrorMessage(e),
          isError: true,
        );
      }
    } catch (e) {
      if (mounted) {
        WidgetsHelper.showSnackBar(
          context,
          ErrorHandling.getErrorMessage(e),
          isError: true,
        );
      }
    }
  }
    /* for login the body is center with singlechildscroll child which has a form child and form has a 
    column then the icon,etc and textfields with elevated button and 
    textbuttons
    for signup and reset , the styles are in the app styles class and validators are in the validators class */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppStyles.buildAppBar("Log In"),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppStyles.headerIcon,
                const SizedBox(height: 20.0),
                const Text(
                  'Welcome Back to Craftly',
                  textAlign: TextAlign.center,
                  style: AppStyles.titleStyle,
                ),
                const SizedBox(height: 5.0),
                const Text(
                  "Log in to continue your crafting journey!",
                  textAlign: TextAlign.center,
                  style: AppStyles.subtitleStyle,
                ),
                const SizedBox(height: 32.0),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (v) =>
                      Validators.validateRequired(v, 'your password'),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _handleLogin,
                  style: AppStyles.primaryButtonStyle,
                  child: const Text('Log In', style: AppStyles.buttonTextStyle),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/signup'),
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/forgot-password'),
                  child: const Text('Forgot password?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
