class EnvConfig {
  EnvConfig._();

  static const String environment = String.fromEnvironment(
    'ENV_NAME',
    defaultValue: 'DEV',
  );
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://newsapi.org/v2/',
  );
  static const String apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: 'GANTI_DENGAN_API_KEY_KAMU',
  );

  static bool get isProduction => environment == 'PROD';

  static String getAppName(String firstName) {
    return isProduction ? 'UTD - 20123040' : 'DEV - $firstName';
  }
}
