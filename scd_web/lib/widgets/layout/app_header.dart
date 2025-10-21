import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../utils/app_constants.dart';
import 'responsive_layout.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.primaryBlack,
      elevation: 2,
      titleSpacing: 12,
      title: InkWell(
        onTap: () => context.go('/'),
        child: Row(
          children: [
            Image.asset('assets/logo.png', height: 40),
            const SizedBox(width: 16),
            if (MediaQuery.of(context).size.width > 950)
              Text(
                'Shark City Drum & Dance Corps',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppTheme.primaryWhite),
              ),
          ],
        ),
      ),
      actions: const [
        ResponsiveLayout(
          mobileBody: MobileNavMenu(),
          desktopBody: DesktopNavMenu(),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}

class DesktopNavMenu extends StatelessWidget {
  const DesktopNavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentRoute = GoRouterState.of(context).uri.toString();

    return Row(
      children: [
        ...navItems.map(
          (item) => TextButton(
            onPressed: () {
              if (currentRoute != item.route) {
                context.go(item.route);
              }
            },
            child: Text(
              item.label,
              style: TextStyle(
                color: currentRoute == item.route
                    ? AppTheme.accentGold
                    : AppTheme.primaryWhite,
                fontWeight: currentRoute == item.route
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () => context.go('/donate'),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppTheme.accentGold),
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          child: Text(
            'Donate',
            style: TextStyle(
              color: AppTheme.primaryBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class MobileNavMenu extends StatelessWidget {
  const MobileNavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu, color: AppTheme.primaryWhite),
      onPressed: () {
        Scaffold.of(context).openEndDrawer();
      },
    );
  }
}
