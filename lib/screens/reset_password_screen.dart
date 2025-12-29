import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/utils/validators.dart';
import 'package:flutter_application_1/utils/error_handling.dart';
import 'package:flutter_application_1/utils/app_styles.dart';
import 'package:flutter_application_1/utils/widgets_helper.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? actionCode;

  const ResetPasswordScreen({super.key, this.actionCode});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Check if we have an action code from the email link
        if (widget.actionCode != null && widget.actionCode!.isNotEmpty) {
          // Use the action code to confirm password reset
          await _authService.confirmPasswordReset(
            code: widget.actionCode!,
            newPassword: _passwordController.text.trim(),
          );
        } else {
          // User is logged in, use updatePassword
          final user = _authService.currentUser;
          if (user != null) {
            await user.updatePassword(_passwordController.text.trim());
            await user.reload();
          } else {
            // If no action code and user not logged in, show error
            throw Exception(
              'Please click the link in your email to reset your password, '
              'or log in first to change your password.',
            );
          }
        }

        if (mounted) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Password reset successfully! Redirecting to login...',
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );

          // Navigate to login after a short delay to show success message
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false, // Remove all previous routes
              );
            }
          });
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
      appBar: AppStyles.buildAppBar("Reset Password"),
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
                  Icons.lock_open,
                  size: 60,
                  color: Color.fromARGB(255, 57, 3, 57),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Set New Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 57, 3, 57),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  widget.actionCode != null
                      ? "Enter your new password below. You will be redirected to login after resetting."
                      : "Enter your new password below. After resetting, you'll be redirected to login.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 32.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscurePassword,
                  onChanged: (value) {
                    // Re-validate confirm password when password changes
                    if (_confirmPasswordController.text.isNotEmpty) {
                      _formKey.currentState?.validate();
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (!Validators.isValidPassword(value)) {
                      return 'Password must be 8+ chars, with number & symbol';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm New Password',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscureConfirmPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _isLoading ? null : _resetPassword,
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
                          'Reset Password',
                          style: AppStyles.buttonTextStyle,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
