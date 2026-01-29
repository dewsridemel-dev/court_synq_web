import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/services/auth_service.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final Widget? logoWidget;
  final String? logoPath;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;
  final int notificationCount;
  final bool showLogo;

  const AppHeader({
    super.key,
    this.logoWidget,
    this.logoPath,
    this.onNotificationTap,
    this.onProfileTap,
    this.notificationCount = 0,
    this.showLogo = true,
  });

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    final String first_name = authService.synQUser?.first_name ?? 'User';
    final String last_name = authService.synQUser?.last_name ?? '';
    final String fill = '$first_name $last_name';
    final String userRole = authService.synQUser?.designation ?? '';

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Logo Section
          if(showLogo)
            _buildDefaultLogo(),

          const Spacer(),

          IconButton(
            onPressed: onNotificationTap ?? () {
              ScaffoldMessenger.of(context).showSnackBar(
                //  TODO: Implement notification functionality
                const SnackBar(content: Text('No Notifications')),
              );
            },
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Color(0xFFF0F3F7),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.notifications_none,
                    color: Color(0xFF63748B),
                    size: 20,
                  ),
                ),
                if (notificationCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        notificationCount > 9 ? '9+' : '$notificationCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // User profile section
          InkWell(
            onTap: onProfileTap ?? () {
              // Default profile handler - could show a menu
              _showProfileMenu(context, authService);
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Color(0xFFF0F3F7),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.person_outline,
                      color: Color(0xFF63748B),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fill,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Color(0xFF63748B),
                        ),
                      ),
                      Text(
                        userRole,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Color(0xFF63748B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultLogo() {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Container(
          width: 140,
          height: 66,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/logo/logo_2x.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
    );
  }

  void _showProfileMenu(BuildContext context, AuthService authService) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(1000, 70, 0, 0),
      color: Colors.white,
      items: [
        const PopupMenuItem(
          value: 'profile',
          child: Row(
            children: [
              Icon(Icons.person_outline, size: 18, color: Color(0xFF63748B)),
              SizedBox(width: 12),
              Text(
                'Profile',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Color(0xFF63748B),
                )
              ),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'settings',
          child: Row(
            children: [
              Icon(Icons.settings_outlined, size: 18, color: Color(0xFF63748B)),
              SizedBox(width: 12),
              Text(
                'Settings',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Color(0xFF63748B),
                )
              ),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout, size: 18, color: Color(0xFF63748B)),
              SizedBox(width: 12),
              Text(
                'Logout',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Color(0xFF63748B),
                )
              ),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == 'logout') {
        authService.signOut();
        Navigator.of(context).pushReplacementNamed('/login');
      } else if (value == 'profile') {
        // TODO: Implement profile navigation
        //Navigator.of(context).pushNamed('/profile');
        const snackBar = SnackBar(content: Text('Profile page is under construction'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (value == 'settings') {
        // TODO: Implement settings navigation
        //Navigator.of(context).pushNamed('/settings');
        const snackBar = SnackBar(content: Text('Settings page is under construction'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}