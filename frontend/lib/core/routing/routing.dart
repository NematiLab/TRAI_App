import 'package:frontend/app/home/view/screen/home_screen.dart';
import 'package:frontend/app/config/view/screen/info_screen.dart';
import 'package:frontend/core/routing/navigation_key.dart';
import 'package:go_router/go_router.dart';

/// This class defines the application's routing configuration using GoRouter.
class AppRouter {
  /// The static instance of GoRouter used for navigation throughout the app.
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey, // The root navigator key for the app
    initialLocation: '/', // The initial route when the app starts
    debugLogDiagnostics: true, // Enable debug logging for route diagnostics
    routes: <RouteBase>[
      // Define the home route
      GoRoute(
        name: 'Home',
        path: '/',
        builder: (context, state) {
          // Return the HomeScreen widget with the extracted userId
          return HomeScreen();
        },
        routes: <GoRoute>[
          // Define the nested route for the info screen
          GoRoute(
            name: 'Info',
            path: 'Info',
            builder: (context, state) {
              // Return the InfoScreen widget
              return const InfoScreen();
            },
          ),
        ],
      ),
    ],
  );
}
