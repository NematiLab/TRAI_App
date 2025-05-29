import 'package:flutter/material.dart';

/// A global key for the root navigator of the application.
/// This key is used to manage navigation and access the navigator state from anywhere in the app.
final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');
