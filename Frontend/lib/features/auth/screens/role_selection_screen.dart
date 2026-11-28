import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import 'login_screen.dart';
import 'register_screen.dart';

enum UserRole { shopOwner, farmer }

/// First screen shown when someone taps "Register" from the login screen.
/// Matches the reference layout: logo header, hero photo with a location
/// badge, headline, and two selectable role cards that decide which
/// registration form (shop owner vs farmer) comes next.
class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  // Defaults to shopOwner, matching the reference image where "I own a
  // shop" appears pre-selected.
  UserRole _selectedRole = UserRole.shopOwner;

  void _onContinuePressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RegisterScreen(initialRole: _selectedRole)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _buildHeroImage(),
              const SizedBox(height: 24),
              Text(
                'Good food.\nCloser than you think.',
                style: AppTextStyles.h1,
              ),
              const SizedBox(height: 8),
              Text(
                'Local farmers. Local shops. Fair prices. Fresh produce.',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 28),
              Text(AppStrings.chooseRole, style: AppTextStyles.h3),
              const SizedBox(height: 12),
              _RoleOptionCard(
                icon: Icons.storefront_outlined,
                title: AppStrings.roleShopOwner,
                subtitle: AppStrings.roleShopOwnerSubtitle,
                selected: _selectedRole == UserRole.shopOwner,
                onTap: () => setState(() => _selectedRole = UserRole.shopOwner),
              ),
              const SizedBox(height: 12),
              _RoleOptionCard(
                icon: Icons.eco_outlined,
                title: AppStrings.roleFarmer,
                subtitle: AppStrings.roleFarmerSubtitle,
                selected: _selectedRole == UserRole.farmer,
                onTap: () => setState(() => _selectedRole = UserRole.farmer),
              ),
              const SizedBox(height: 24),
              CustomButton(
                label: _selectedRole == UserRole.shopOwner
                    ? AppStrings.continueAsShopOwner
                    : AppStrings.continueAsFarmer,
                icon: Icons.arrow_forward,
                onPressed: _onContinuePressed,
              ),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      style: AppTextStyles.bodySmall,
                      children: [
                        const TextSpan(text: 'Already part of doko? '),
                        TextSpan(
                          text: 'Sign in',
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

  /// Logo + wordmark on the left, small tagline on the right — matches
  /// the reference header exactly.
  ///
  /// NOTE: swap the Image.asset path below for wherever your actual logo
  /// file ends up. Keeping it inside the already-registered
  /// `assets/images/` folder (rather than a new `assets/images/logo/`
  /// subfolder) means you don't need to add another line to pubspec.yaml —
  /// see the explanation below the code for why that matters.
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 26,
              width: 26,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.eco, color: AppColors.primaryDark, size: 26),
            ),
            const SizedBox(width: 8),
            Text(
              AppStrings.appName,
              style: AppTextStyles.h2.copyWith(color: AppColors.primaryDark),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            'GROWN NEAR. SHARED FAIR.',
            style: AppTextStyles.caption.copyWith(letterSpacing: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 190,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Reuses the same photo as the login banner — swap for a
            // different image if you'd rather not repeat it.
            Image.asset('assets/images/register_banner.png', fit: BoxFit.cover),
            Positioned(
              left: 12,
              bottom: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on_outlined, size: 14, color: AppColors.primaryDark),
                    const SizedBox(width: 4),
                    Text(
                      'From farms around you',
                      style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Selectable role card — highlights with the brand green background and
/// a filled radio dot when selected, matching the reference image.
class _RoleOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _RoleOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryLight.withOpacity(0.25) : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.primaryDark : AppColors.border,
            width: selected ? 1.4 : 0.6,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryDark, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTextStyles.bodySmall),
                ],
              ),
            ),
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? AppColors.primaryDark : AppColors.border,
            ),
          ],
        ),
      ),
    );
  }
}