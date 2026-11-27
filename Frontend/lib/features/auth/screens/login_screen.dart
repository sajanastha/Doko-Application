import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPhotoBanner(),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.welcomeBack, style: AppTextStyles.h1),
                    const SizedBox(height: 6),
                    Text(
                      AppStrings.welcomeBackSubtitle,
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 28),

                    CustomTextField(
                      label: AppStrings.usernameOrEmail,
                      controller: _usernameController,
                      hintText: 'e.g. maya@dokoapp.com',
                      prefixIcon: Icons.person_outline,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: AppStrings.password,
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          size: 20,
                          color: AppColors.textSecondary,
                        ),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 22,
                              width: 22,
                              child: Checkbox(
                                value: _rememberMe,
                                activeColor: AppColors.primary,
                                onChanged: (v) => setState(() => _rememberMe = v ?? false),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(AppStrings.rememberMe, style: AppTextStyles.bodySmall),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: navigate to forgot-password flow
                          },
                          child: Text(
                            AppStrings.forgotPassword,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    CustomButton(
                      label: AppStrings.login,
                      onPressed: () {
                        // TODO: call auth_controller.login(...)
                      },
                    ),
                    const SizedBox(height: 24),

                    _buildDividerWithText('OR'),
                    const SizedBox(height: 20),

                    CustomButton(
                      label: 'Sign in with Google',
                      isOutlined: true,
                      icon: Icons.g_mobiledata, // swap for a proper Google logo asset
                      onPressed: () {},
                    ),
                    const SizedBox(height: 12),
                    CustomButton(
                      label: 'Sign in with Apple',
                      isOutlined: true,
                      icon: Icons.apple,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 28),

                    // "Don't have an account? Register" — replaces the
                    // tab-switcher pattern from the reference image.
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyles.bodyMedium,
                          children: [
                            const TextSpan(text: "Don't have an account? "),
                            TextSpan(
                              text: 'Register',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.primaryDark,
                                fontWeight: FontWeight.w700,
                              ),
                              // Wrap with a GestureRecognizer (TapGestureRecognizer)
                              // to navigate to the role-selection/registration screen.
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Full-bleed photo banner with a dark gradient fade at the bottom

  Widget _buildPhotoBanner() {
    return SizedBox(
      height: 260,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // --- The banner photo itself ---
          Image.asset(
            'assets/images/login-image.jpg',
            fit: BoxFit.cover,
          ),
          // --- Gradient overlay so white text stays readable ---
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xCC1B5E20)], // fades to primaryDark
                stops: [0.4, 1.0],
              ),
            ),
          ),
          // --- App name + tagline over the photo ---
          Positioned(
            left: 24,
            right: 24,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.appName,
                  style: AppTextStyles.h1.copyWith(color: AppColors.textOnDark, fontSize: 32),
                ),
                const SizedBox(height: 4),
                Text(
                  AppStrings.appTagline,
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textOnDark.withOpacity(0.9)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDividerWithText(String text) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(text, style: AppTextStyles.bodySmall),
        ),
        Expanded(child: Divider(color: AppColors.border)),
      ],
    );
  }
}