import 'package:flutter/material.dart';

class NavItem {
  final String label;
  final String route;
  final IconData? icon;

  const NavItem({required this.label, required this.route, this.icon});
}

const List<NavItem> navItems = [
  NavItem(label: 'Home', route: '/'),
  NavItem(label: 'About', route: '/about'),
  NavItem(label: 'Events', route: '/events'),
  NavItem(label: 'Media', route: '/media'),
  NavItem(label: 'Join Us', route: '/join'),
  NavItem(label: 'Contact', route: '/contact'),
];
