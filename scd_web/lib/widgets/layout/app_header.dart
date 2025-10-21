import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scd_web/config/theme.dart';
import 'package:scd_web/utils/app_constants.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return AppBar(
      title: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => context.go('/'),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/logo.png', height: 32),
              const SizedBox(width: 8),
              const Text('Shark City'),
            ],
          ),
        ),
      ),
      actions: isMobile
          ? [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ]
          : [
              ...navItems.map(
                (item) => TextButton(
                  onPressed: () => context.go(item.route),
                  child: Text(
                    item.label,
                    style: const TextStyle(color: AppTheme.onBackground),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => context.go('/donate'),
                child: const Text('Donate'),
              ),
              const SizedBox(width: 16),
            ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
