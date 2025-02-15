import 'package:flutter/material.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with curve
          Positioned.fill(
            child: CustomPaint(
              painter: CurvedBackgroundPainter(),
            ),
          ),
          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  // Profile Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Avatar with edit button
                        Stack(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/profil.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Name
                        const Text(
                          'linda mira',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Contact info
                        const Text(
                          'lindaMirea@domain.com | +213 534 567 89',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Settings Sections
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildSettingsCard([
                          SettingItem(
                            icon: Icons.person_outline,
                            title: 'Edit profile information',
                            onTap: () {},
                          ),
                          SettingItem(
                            icon: Icons.translate,
                            title: 'Language',
                            trailing: 'English',
                            onTap: () {},
                          ),
                        ]),
                        const SizedBox(height: 16),
                        _buildSettingsCard([
                          SettingItem(
                            icon: Icons.security,
                            title: 'Security',
                            onTap: () {},
                          ),
                          SettingItem(
                            icon: Icons.palette_outlined,
                            title: 'Theme',
                            trailing: 'Light mode',
                            onTap: () {},
                          ),
                        ]),
                        const SizedBox(height: 16),
                        _buildSettingsCard([
                          SettingItem(
                            icon: Icons.payment,
                            title: 'Payment',
                            onTap: () {},
                          ),
                          SettingItem(
                            icon: Icons.location_on_outlined,
                            title: 'Address',
                            onTap: () {},
                          ),
                        ]),
                        const SizedBox(height: 16),
                        _buildSettingsCard([
                          SettingItem(
                            icon: Icons.help_outline,
                            title: 'Help & Support',
                            onTap: () {},
                          ),
                          SettingItem(
                            icon: Icons.lock_outline,
                            title: 'Privacy policy',
                            onTap: () {},
                          ),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }
}

class CurvedBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw the background in light pink.
    final paint = Paint()
      ..color = const Color(0xFFFCE4EC) // Light pink background
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, 300),
      paint,
    );

    // Draw the white shape with an inverted curve.
    paint.color = Colors.white;
    final path = Path();
    // Start at the left at 35% of the height.
    path.moveTo(0, size.height * 0.35);
    // Invert the curve by placing the control point lower (at 45% height)
    // This causes the curve to dip downward instead of upward.
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.45, // Moved from 0.25 to 0.45 to invert the curve.
      size.width,
      size.height * 0.35,
    );
    // Draw the rest of the shape covering the bottom.
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailing;
  final VoidCallback onTap;

  const SettingItem({
    Key? key,
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: Colors.black87,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
            if (trailing != null)
              Text(
                trailing!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            if (trailing == null)
              const Icon(
                Icons.chevron_right,
                color: Colors.black54,
              ),
          ],
        ),
      ),
    );
  }
}