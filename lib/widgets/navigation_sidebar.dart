import 'package:flutter/material.dart';

class NavigationItem {
  final String title;
  final IconData icon;
  final String? route;
  final List<NavigationItem>? children;
  final bool isExpanded;

  NavigationItem({
    required this.title,
    required this.icon,
    this.route,
    this.children,
    this.isExpanded = false,
  });
}

class NavigationSidebar extends StatefulWidget {
  final String selectedRoute;
  final Function(String) onNavigate;
  final bool isCollapsed;
  final Function(bool) onToggleCollapse;

  const NavigationSidebar({
    super.key,
    required this.selectedRoute,
    required this.onNavigate,
    required this.isCollapsed,
    required this.onToggleCollapse,
  });

  @override
  State<NavigationSidebar> createState() => _NavigationSidebarState();
}

class _NavigationSidebarState extends State<NavigationSidebar> {
  final Map<String, bool> _expandedItems = {
    'Court Management': true,
    'Facility Management': false,
    'Business Profile': false,
  };

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      title: 'Dashboard',
      icon: Icons.dashboard_outlined,
      route: '/dashboard',
    ),
    NavigationItem(
      title: 'Booking History',
      icon: Icons.calendar_today_outlined,
      route: '/booking-history',
    ),
    NavigationItem(
      title: 'Court Management',
      icon: Icons.business_outlined,
      children: [
        NavigationItem(
          title: 'Court Details',
          icon: Icons.list_outlined,
          route: '/court-details',
        ),
        NavigationItem(
          title: 'Pricing',
          icon: Icons.price_tag_outlined,
          route: '/pricing',
        ),
      ],
    ),
    NavigationItem(
      title: 'Facility Management',
      icon: Icons.build_outlined,
      children: [
        NavigationItem(
          title: 'Facilities',
          icon: Icons.room_outlined,
          route: '/facilities',
        ),
        NavigationItem(
          title: 'Equipment',
          icon: Icons.sports_outlined,
          route: '/equipment',
        ),
      ],
    ),
    NavigationItem(
      title: 'Business Profile',
      icon: Icons.briefcase_outlined,
      children: [
        NavigationItem(
          title: 'Profile Settings',
          icon: Icons.settings_outlined,
          route: '/profile-settings',
        ),
        NavigationItem(
          title: 'Business Info',
          icon: Icons.info_outlined,
          route: '/business-info',
        ),
      ],
    ),
    NavigationItem(
      title: 'Staff Management',
      icon: Icons.people_outlined,
      route: '/staff-management',
    ),
    NavigationItem(
      title: 'Promotion',
      icon: Icons.local_offer_outlined,
      route: '/promotion',
    ),
    NavigationItem(
      title: 'Insights',
      icon: Icons.bar_chart_outlined,
      route: '/insights',
    ),
    NavigationItem(
      title: 'Help Center',
      icon: Icons.help_outline,
      route: '/help-center',
    ),
  ];

  void _toggleExpansion(String title) {
    setState(() {
      _expandedItems[title] = !(_expandedItems[title] ?? false);
    });
  }

  bool _isItemSelected(NavigationItem item) {
    if (item.route == widget.selectedRoute) {
      return true;
    }
    if (item.children != null) {
      return item.children!.any((child) => child.route == widget.selectedRoute);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.isCollapsed ? 80 : 280,
      color: Colors.grey.shade50,
      child: Column(
        children: [
          // Logo and Toggle Button
          Container(
            padding: EdgeInsets.all(widget.isCollapsed ? 16 : 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              mainAxisAlignment: widget.isCollapsed
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                if (!widget.isCollapsed)
                  Row(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            Colors.purple,
                            Colors.pink,
                          ],
                        ).createShader(bounds),
                        child: const Text(
                          'Court SynQ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  const Text(
                    'C',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                IconButton(
                  icon: Icon(
                    widget.isCollapsed
                        ? Icons.chevron_right
                        : Icons.chevron_left,
                    size: 20,
                  ),
                  onPressed: () => widget.onToggleCollapse(!widget.isCollapsed),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          // Navigation Items
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _navigationItems.length,
              itemBuilder: (context, index) {
                return _buildNavigationItem(_navigationItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItem(NavigationItem item) {
    final hasChildren = item.children != null && item.children!.isNotEmpty;
    final isExpanded = _expandedItems[item.title] ?? false;
    final isSelected = _isItemSelected(item);

    return Column(
      children: [
        InkWell(
          onTap: () {
            if (hasChildren) {
              _toggleExpansion(item.title);
            } else if (item.route != null) {
              widget.onNavigate(item.route!);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: widget.isCollapsed ? 12 : 20,
              vertical: 16,
            ),
            color: isSelected && !hasChildren
                ? Colors.purple.shade50
                : Colors.transparent,
            child: Row(
              children: [
                Icon(
                  item.icon,
                  color: isSelected && !hasChildren
                      ? Colors.purple
                      : Colors.grey.shade700,
                  size: 24,
                ),
                if (!widget.isCollapsed) ...[
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      item.title,
                      style: TextStyle(
                        color: isSelected && !hasChildren
                            ? Colors.purple
                            : Colors.grey.shade700,
                        fontWeight: isSelected && !hasChildren
                            ? FontWeight.w600
                            : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  if (hasChildren)
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 20,
                      color: Colors.grey.shade600,
                    ),
                ],
              ],
            ),
          ),
        ),
        // Sub-items
        if (hasChildren && isExpanded && !widget.isCollapsed)
          ...item.children!.map((child) {
            final isChildSelected = child.route == widget.selectedRoute;
            return InkWell(
              onTap: () {
                if (child.route != null) {
                  widget.onNavigate(child.route!);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                margin: const EdgeInsets.only(left: 40),
                decoration: BoxDecoration(
                  color: isChildSelected
                      ? Colors.purple.shade50
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      child.icon,
                      color: isChildSelected
                          ? Colors.purple
                          : Colors.grey.shade600,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        child.title,
                        style: TextStyle(
                          color: isChildSelected
                              ? Colors.purple
                              : Colors.grey.shade700,
                          fontWeight: isChildSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
      ],
    );
  }
}