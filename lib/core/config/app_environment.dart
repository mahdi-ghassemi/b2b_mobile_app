class AppEnvironment {
  final String baseUrl;
  final String apiKey;
  final String apiKeyHeaderName;

  const AppEnvironment({
    required this.baseUrl,
    required this.apiKey,
    required this.apiKeyHeaderName,
  });

  static const AppEnvironment current = AppEnvironment(
    baseUrl: String.fromEnvironment(
      'BASE_URL',
      defaultValue: 'http://172.20.10.9:8080',
    ),
    apiKey: String.fromEnvironment(
      'API_KEY',
      defaultValue: '6LeMBPkrAAAAAAHgIq7puQLJHu0LDLmusgHVqtke',
    ),
    apiKeyHeaderName: String.fromEnvironment(
      'API_KEY_HEADER',
      defaultValue: 'X-API-Key',
    ),
  );
}
