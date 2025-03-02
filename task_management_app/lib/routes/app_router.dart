import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../views/dashboard/dashboard.dart';

import '../views/loginscreen/login_screen.dart';
import '../views/loginscreen/signup_screen.dart';
import '../views/loginscreen/forgot_password_screen.dart';
import '../views/task_screens/create_task_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login', // Set the initial screen
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => HomeScreen(), // ✅ Default home screen is now Dashboard
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgotPassword',
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => SignupScreen(),
      ),
      // GoRoute(
      //   path: '/dashboard',
      //   name: 'dashboard',
      //   builder: (context, state) => HomeScreen(),
      // ),
      GoRoute(
        path: '/create-task',
        name: 'addTask',
        builder: (context, state) => CreateTaskScreen(),
      ),
      GoRoute(
        path: '/task/:taskId',
        name: 'viewTask',
        builder: (context, state) {
          final taskId = state.pathParameters['taskId']!;
          // return ViewTaskScreen(taskId: taskId);
          return CreateTaskScreen();
        },
      ),
    ],
  );
}
