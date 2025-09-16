// API Configuration Template
// Copy this file to api_config.dart and add your actual API keys
// DO NOT commit api_config.dart to version control

class ApiConfig {
  // Translation API Keys
  // TODO: Add your actual API keys here
  static const String googleTranslateApiKey = 'YOUR_GOOGLE_TRANSLATE_API_KEY_HERE';
  static const String microsoftTranslatorKey = 'YOUR_MICROSOFT_TRANSLATOR_KEY_HERE';
  static const String microsoftTranslatorEndpoint = 'YOUR_MICROSOFT_TRANSLATOR_ENDPOINT_HERE';
  static const String deepLApiKey = 'YOUR_DEEPL_API_KEY_HERE';
  
  // Speech API Configuration
  static const String googleSpeechApiKey = 'YOUR_GOOGLE_SPEECH_API_KEY_HERE';
  static const String azureSpeechKey = 'YOUR_AZURE_SPEECH_KEY_HERE';
  static const String azureSpeechRegion = 'YOUR_AZURE_SPEECH_REGION_HERE';
  
  // Default API provider ('google', 'microsoft', 'deepl')
  static const String defaultTranslationProvider = 'google';
  static const String defaultSpeechProvider = 'google';
  
  // API Endpoints
  static const String googleTranslateApiUrl = 'https://translation.googleapis.com/language/translate/v2';
  static const String microsoftTranslatorApiUrl = 'https://api.cognitive.microsofttranslator.com/translate';
  static const String deepLApiUrl = 'https://api-free.deepl.com/v2/translate'; // Use api.deepl.com for pro
  
  // App Configuration
  static const bool enableAnalytics = false; // Set to true when you add analytics
  static const bool enableCrashlytics = false; // Set to true when you add crashlytics
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';
  
  // Feature Flags
  static const bool enableOfflineMode = false; // Premium feature
  static const bool enableCloudSync = false; // Premium feature
  static const int maxFreeTranslationsPerDay = 100;
  static const int maxFreeHistoryItems = 50;
  
  // Validate API keys
  static bool get hasValidGoogleTranslateKey => 
      googleTranslateApiKey.isNotEmpty && 
      googleTranslateApiKey != 'YOUR_GOOGLE_TRANSLATE_API_KEY_HERE';
  
  static bool get hasValidMicrosoftTranslatorKey => 
      microsoftTranslatorKey.isNotEmpty && 
      microsoftTranslatorKey != 'YOUR_MICROSOFT_TRANSLATOR_KEY_HERE';
  
  static bool get hasValidDeepLKey => 
      deepLApiKey.isNotEmpty && 
      deepLApiKey != 'YOUR_DEEPL_API_KEY_HERE';
  
  // Get the currently configured translation provider
  static String get currentTranslationProvider {
    switch (defaultTranslationProvider) {
      case 'google':
        return hasValidGoogleTranslateKey ? 'google' : _fallbackProvider;
      case 'microsoft':
        return hasValidMicrosoftTranslatorKey ? 'microsoft' : _fallbackProvider;
      case 'deepl':
        return hasValidDeepLKey ? 'deepl' : _fallbackProvider;
      default:
        return _fallbackProvider;
    }
  }
  
  static String get _fallbackProvider {
    if (hasValidGoogleTranslateKey) return 'google';
    if (hasValidMicrosoftTranslatorKey) return 'microsoft';
    if (hasValidDeepLKey) return 'deepl';
    return 'mock'; // Use mock provider if no keys are configured
  }
}

// API Setup Instructions:
//
// 1. GOOGLE TRANSLATE API:
//    - Go to https://console.cloud.google.com/
//    - Create a new project or select existing
//    - Enable Cloud Translation API
//    - Create credentials (API Key)
//    - Add your API key above
//
// 2. MICROSOFT TRANSLATOR:
//    - Go to https://portal.azure.com/
//    - Create a Translator resource
//    - Get your subscription key and endpoint
//    - Add them above
//
// 3. DEEPL API:
//    - Sign up at https://www.deepl.com/pro-api
//    - Get your authentication key
//    - Add it above
//
// 4. GOOGLE SPEECH SERVICES:
//    - In Google Cloud Console, enable:
//      * Speech-to-Text API
//      * Text-to-Speech API
//    - Use the same API key or create a separate one
//
// Remember to:
// - Keep your API keys secure
// - Monitor your usage to avoid unexpected charges
// - Set up usage quotas and alerts in your API provider consoles
// - Never commit api_config.dart to version control