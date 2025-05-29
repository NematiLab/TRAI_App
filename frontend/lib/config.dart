// ignore_for_file: non_constant_identifier_names
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// A class that holds the configuration values for the application.
class Config {
  static final String triagePlatformApiUrl =
      dotenv.get('TRIAGE_PLATFORM_API_URL');
}
