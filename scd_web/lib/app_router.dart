// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:scd_web/data/services/auth_service.dart';
import 'package:go_router/go_router.dart';
import 'pages/home_page_static.dart'; // Using static version temporarily
import 'pages/about_page.dart';
import 'pages/events_page.dart';
import 'pages/media_page.dart';
import 'pages/join_us_page.dart';
import 'pages/contact_page.dart';
import 'pages/donate_page.dart';
import 'pages/admin/dashboard_page.dart';
import 'pages/admin/login_page.dart';
import 'widgets/layout/main_layout.dart';

class AppRouter {
  static GoRouter createRouter(AuthService authService) {
    return GoRouter(
      initialLocation: '/',
      refreshListenable: authService,
      redirect: (context, state) {
        final isAuthenticated = authService.isAuthenticated;
        final isLoggingIn = state.matchedLocation == '/admin/login';
        final isAdminRoute = state.matchedLocation.startsWith('/admin');

        // If user is not authenticated and tries to access an admin route, redirect to login
        if (!isAuthenticated && isAdminRoute && !isLoggingIn) {
          return '/admin/login';
        }

        // If user is authenticated and tries to access login page, redirect to admin dashboard
        if (isAuthenticated && isLoggingIn) {
          return '/admin';
        }

        return null; // No redirect needed
      },
      routes: [
        // Public Routes
        GoRoute(
          path: '/',
          builder: (c, s) => const MainLayout(child: HomePageStatic()),
        ),
        GoRoute(
          path: '/about',
          builder: (c, s) => const MainLayout(child: AboutPage()),
        ),
        GoRoute(
          path: '/events',
          builder: (c, s) => const MainLayout(child: EventsPage()),
        ),
        GoRoute(
          path: '/media',
          builder: (c, s) => const MainLayout(child: MediaPage()),
        ),
        GoRoute(
          path: '/join',
          builder: (c, s) => const MainLayout(child: JoinUsPage()),
        ),
        GoRoute(
          path: '/contact',
          builder: (c, s) => const MainLayout(child: ContactPage()),
        ),
        GoRoute(
          path: '/donate',
          builder: (c, s) => const MainLayout(child: DonatePage()),
        ),

        // Admin Routes
        GoRoute(path: '/admin/login', builder: (c, s) => const LoginPage()),
        GoRoute(path: '/admin', builder: (c, s) => const AdminDashboardPage()),
      ],
    );
  }
}
