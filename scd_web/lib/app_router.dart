// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/events_page.dart';
import 'pages/media_page.dart';
import 'pages/join_us_page.dart';
import 'pages/contact_page.dart';
import 'pages/donate_page.dart';
import 'widgets/layout/main_layout.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainLayout(child: HomePage()),
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) => const MainLayout(child: AboutPage()),
      ),
      GoRoute(
        path: '/events',
        builder: (context, state) => const MainLayout(child: EventsPage()),
      ),
      GoRoute(
        path: '/media',
        builder: (context, state) => const MainLayout(child: MediaPage()),
      ),
      GoRoute(
        path: '/join',
        builder: (context, state) => const MainLayout(child: JoinUsPage()),
      ),
      GoRoute(
        path: '/contact',
        builder: (context, state) => const MainLayout(child: ContactPage()),
      ),
      GoRoute(
        path: '/donate',
        builder: (context, state) => const MainLayout(child: DonatePage()),
      ),
    ],
  );
}
