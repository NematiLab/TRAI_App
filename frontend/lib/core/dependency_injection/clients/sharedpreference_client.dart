import 'package:logger/logger.dart';

import '../../sharepreference_manager/shared_preferences_manager.dart';

/// This class provides a client for managing shared preferences.
class SharedPreferencesManagerClient {
  final logger = Logger(); // Logger instance for logging information

  final _sharedPreferencesManager =
      SharedPreferencesManager(); // Instance of SharedPreferencesManager

  /// Constructor to initialize the SharedPreferencesManagerClient.
  /// Logs the creation of the SharedPreferencesManagerClient.
  SharedPreferencesManagerClient() {
    logger.i(
        'Got a SharedPreferencesManagerClient'); // Log the creation of the client
  }

  /// Getter to access the SharedPreferencesManager instance.
  SharedPreferencesManager get sharedPreferencesManager =>
      _sharedPreferencesManager;
}
