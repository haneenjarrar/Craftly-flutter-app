import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/utils/validators.dart';
import 'package:flutter_application_1/utils/error_handling.dart';
import 'package:flutter_application_1/utils/app_styles.dart';
import 'package:flutter_application_1/utils/widgets_helper.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetEmail() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _authService.resetPassword(email: _emailController.text.trim());

        if (mounted) {
          // Show success dialog with option to go to reset screen
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Reset Email Sent'),
              content: Text(
                'A password reset link has been sent to ${_emailController.text.trim()}. '
                'Please check your email and click the link. '
                'After clicking the link, you can set your new password.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(); // Go back to login
                  },
                  child: const Text('Back to Login'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate to reset password screen
                    Navigator.pushReplacementNamed(context, '/reset-password');
                  },
                  child: const Text('Set New Password'),
                ),
              ],
            ),
          );
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
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppStyles.buildAppBar("Forgot Password"),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.lock_reset,
                  size: 60,
                  color: Color.fromARGB(255, 57, 3, 57),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Reset Your Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 57, 3, 57),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Enter your email address and we'll send you a link to reset your password.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 32.0),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _isLoading ? null : _sendResetEmail,
                  style: AppStyles.primaryButtonStyle,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text(
                          'Send Reset Link',
                          style: AppStyles.buttonTextStyle,
                        ),
                ),
                const SizedBox(height: 15.0),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back to Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
