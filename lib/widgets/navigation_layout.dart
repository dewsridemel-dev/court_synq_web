import 'package:flutter/material.dart';
import 'navigation_sidebar.dart';
import 'app_header.dart';
import 'navigation_page_view.dart';

class NavigationLayout extends StatefulWidget {
  final Widget child;

  const NavigationLayout({
    super.key,
    required this.child,
  });

  @override
  State<NavigationLayout> createState() => _NavigationLayoutState();
}

class _NavigationLayoutState extends State<NavigationLayout> {
  bool _isSidebarCollapsed = false;
  String _currentRoute = '/dashboard';

  void _handleNavigation(String route) {
    setState(() {
      _currentRoute = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;
        final isTablet = constraints.maxWidth < 1024 && constraints.maxWidth >= 768;

        // On mobile, show sidebar as drawer
        if (isMobile) {
          return Scaffold(
            drawer: SizedBox(
              width: 280,
              child: NavigationSidebar(
                selectedRoute: _currentRoute,
                onNavigate: (route) {
                  _handleNavigation(route);
                  Navigator.of(context).pop();
                },
                isCollapsed: false,
                onToggleCollapse: (collapsed) {},
              ),
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const AppHeader(),
                  Expanded(
                    child: NavigationPageView(
                      currentRoute: _currentRoute,
                      child: widget.child,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Desktop/Tablet layout
        return Scaffold(
          body: Row(
            children: [
              // Sidebar
              NavigationSidebar(
                selectedRoute: _currentRoute,
                onNavigate: _handleNavigation,
                isCollapsed: _isSidebarCollapsed,
                onToggleCollapse: (collapsed) {
                  setState(() {
                    _isSidebarCollapsed = collapsed;
                  });
                },
              ),
              // Main content area
              Expanded(
                child: Column(
                  children: [
                    const AppHeader(),
                    Expanded(
                      child: NavigationPageView(
                        currentRoute: _currentRoute,
                        child: widget.child,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}