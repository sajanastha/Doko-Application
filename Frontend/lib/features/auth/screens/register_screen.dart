import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import 'login_screen.dart';
import 'role_selection_screen.dart'; // reuses the UserRole enum

/// Single registration screen covering both shop owner and farmer sign-up,
/// matching the reference layout exactly: same header/back button, a
/// segmented toggle to switch roles without leaving the screen, and a
/// field list + button label that swap depending on which role is active.
///
/// [initialRole] is passed in from RoleSelectionScreen so the correct form
/// shows first — but the toggle still lets someone change their mind here
/// without navigating back.
class RegisterScreen extends StatefulWidget {
  final UserRole initialRole;

  const RegisterScreen({super.key, required this.initialRole});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late UserRole _role = widget.initialRole;
  bool _agreedToTerms = true; // defaults checked, matching the reference image
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // --- Shared controllers ---
  final _fullNameController = TextEditingController();
  final _businessNameController = TextEditingController(); // Shop name OR Farm name
  final _mobileController = TextEditingController();
  final _locationController = TextEditingController(); // Shop address OR Farm location
  final _cropsController = TextEditingController(); // Farmer-only: "What do you grow?"
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool get _isShopOwner => _role == UserRole.shopOwner;

  @override
  void dispose() {
    _fullNameController.dispose();
    _businessNameController.dispose();
    _mobileController.dispose();
    _locationController.dispose();
    _cropsController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.mustAgreeToTerms)),
      );
      return;
    }
    // TODO: wire to auth_controller.registerShopOwner(...) or
    // auth_controller.registerFarmer(...) once Firebase Auth is connected
    // (step 4 of the build order).
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              Text(
                _isShopOwner ? AppStrings.joinCommunityLabel.toUpperCase() : AppStrings.grownLocallyLabel.toUpperCase(),
                style: AppTextStyles.caption.copyWith(letterSpacing: 0.6),
              ),
              const SizedBox(height: 8),
              Text(
                _isShopOwner ? AppStrings.shopOwnerRegisterTitle : AppStrings.farmerRegisterTitle,
                style: AppTextStyles.h1,
              ),
              const SizedBox(height: 8),
              Text(
                _isShopOwner ? AppStrings.shopOwnerRegisterSubtitle : AppStrings.farmerRegisterSubtitle,
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 20),
              _buildRoleToggle(),
              const SizedBox(height: 24),

              CustomTextField(
                label: AppStrings.fullName,
                controller: _fullNameController,
                hintText: 'Your full name',
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: _isShopOwner ? AppStrings.shopName : AppStrings.farmName,
                controller: _businessNameController,
                hintText: _isShopOwner ? 'e.g. Maya Fresh Store' : "e.g. Sunita's Farm",
                prefixIcon: _isShopOwner ? Icons.storefront_outlined : Icons.eco_outlined,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: AppStrings.mobileNumber,
                controller: _mobileController,
                hintText: '+977 | 98XXXXXXXX',
                prefixIcon: Icons.call_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: _isShopOwner ? AppStrings.shopAddress : AppStrings.farmLocation,
                controller: _locationController,
                hintText: _isShopOwner ? 'Area, municipality or city' : 'Village, municipality or district',
                prefixIcon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 16),

              // Farmer-only field — only rendered when the Farmer tab is active.
              if (!_isShopOwner) ...[
                CustomTextField(
                  label: AppStrings.whatDoYouGrow,
                  controller: _cropsController,
                  hintText: 'e.g. Tomatoes, spinach, cauliflower',
                  prefixIcon: Icons.grass_outlined,
                ),
                const SizedBox(height: 16),
              ],

              CustomTextField(
                label: AppStrings.password,
                controller: _passwordController,
                obscureText: _obscurePassword,
                hintText: AppStrings.createPassword,
                helperText: AppStrings.passwordHint,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: AppStrings.confirmPassword,
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                hintText: 'Re-enter your password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                ),
              ),
              const SizedBox(height: 14),

              _buildTermsCheckbox(),
              const SizedBox(height: 20),

              CustomButton(
                label: _isShopOwner ? AppStrings.createShopAccount : AppStrings.createFarmAccount,
                icon: Icons.arrow_forward,
                onPressed: _onSubmit,
              ),
              const SizedBox(height: 16),

              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: AppTextStyles.bodySmall,
                      children: [
                        TextSpan(text: '${AppStrings.alreadyHaveAccount} '),
                        TextSpan(
                          text: AppStrings.login,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primaryDark,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
        Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 22,
              width: 22,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.eco, color: AppColors.primaryDark, size: 22),
            ),
            const SizedBox(width: 6),
            Text(AppStrings.appName, style: AppTextStyles.h3.copyWith(color: AppColors.primaryDark)),
          ],
        ),
        TextButton(
          onPressed: () {
            // TODO: link to a help/FAQ screen
          },
          child: Text(AppStrings.help, style: AppTextStyles.bodySmall),
        ),
      ],
    );
  }

  /// The "Shop owner / Farmer" segmented toggle — switching this swaps the
  /// headline, labels, and the farmer-only "What do you grow?" field.
  Widget _buildRoleToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ToggleTab(
              icon: Icons.storefront_outlined,
              label: 'Shop owner',
              selected: _isShopOwner,
              onTap: () => setState(() => _role = UserRole.shopOwner),
            ),
          ),
          Expanded(
            child: _ToggleTab(
              icon: Icons.eco_outlined,
              label: 'Farmer',
              selected: !_isShopOwner,
              onTap: () => setState(() => _role = UserRole.farmer),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 22,
          width: 22,
          child: Checkbox(
            value: _agreedToTerms,
            activeColor: AppColors.primary,
            onChanged: (v) => setState(() => _agreedToTerms = v ?? false),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text.rich(
              TextSpan(
                style: AppTextStyles.bodySmall,
                children: [
                  const TextSpan(text: "I agree to Doko's "),
                  TextSpan(
                    text: 'Terms of service',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy policy',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ToggleTab extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ToggleTab({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryDark : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: selected ? AppColors.textOnDark : AppColors.textSecondary),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: selected ? AppColors.textOnDark : AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}