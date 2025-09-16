# Real-Time Translator Flutter App

A powerful mobile application for real-time translation with support for text, voice, conversation, and image translation using Flutter.

## Features

- **Text Translation**: Translate text between multiple languages with instant results
- **Voice Translation**: Speak in one language and get audio translation in another
- **Conversation Mode**: Real-time conversation translation for seamless communication
- **Image Translation (OCR)**: Extract and translate text from images using ML Kit
- **Translation History**: Save and manage your translation history with favorites
- **Multi-language Support**: Support for 10+ major languages
- **Offline Capabilities**: Basic offline functionality (Premium feature)
- **Cloud Sync**: Sync history across devices (Premium feature)

## Prerequisites

Before you begin, ensure you have the following installed:

- [Flutter](https://flutter.dev/docs/get-started/install) (3.1.0 or higher)
- [Dart](https://dart.dev/get-dart) (3.1.0 or higher)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
- [Xcode](https://developer.apple.com/xcode/) (for iOS development)

## Installation & Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd flutter_translator_app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Platform-Specific Setup

#### Android Setup

1. **Permissions**: Add the following permissions to `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Internet permission for translation APIs -->
    <uses-permission android:name="android.permission.INTERNET" />
    
    <!-- Camera permission for image translation -->
    <uses-permission android:name="android.permission.CAMERA" />
    
    <!-- Microphone permission for voice translation -->
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    
    <!-- Storage permissions for image picker -->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    
    <!-- Optional: Location for region-specific translations -->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    
    <application
        android:label="Real-Time Translator"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        
        <!-- Add this for ML Kit -->
        <meta-data
            android:name="com.google.mlkit.vision.DEPENDENCIES"
            android:value="ocr" />
            
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <!-- Standard configuration -->
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter android:autoVerify="true">
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        
        <!-- Camera provider for image picker -->
        <provider
            android:name="androidx.core.content.FileProvider"
            android:authorities="${applicationId}.flutter_translator_app.fileprovider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/flutter_translator_app_file_paths" />
        </provider>
    </application>
</manifest>
```

2. **File Provider**: Create `android/app/src/main/res/xml/flutter_translator_app_file_paths.xml`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<paths xmlns:android="http://schemas.android.com/apk/res/android">
    <cache-path name="cache" path="." />
    <external-files-path name="external_files" path="." />
</paths>
```

3. **Min SDK Version**: Update `android/app/build.gradle`:

```gradle
android {
    compileSdkVersion 34
    
    defaultConfig {
        applicationId "com.example.flutter_translator_app"
        minSdkVersion 21  // Required for ML Kit
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.0"
    }
}
```

#### iOS Setup

1. **Permissions**: Add the following to `ios/Runner/Info.plist`:

```xml
<dict>
    <!-- Camera permission for image translation -->
    <key>NSCameraUsageDescription</key>
    <string>This app needs camera access to capture images for text translation.</string>
    
    <!-- Photo library permission -->
    <key>NSPhotoLibraryUsageDescription</key>
    <string>This app needs photo library access to select images for text translation.</string>
    
    <!-- Microphone permission for voice translation -->
    <key>NSMicrophoneUsageDescription</key>
    <string>This app needs microphone access for voice translation features.</string>
    
    <!-- Speech recognition permission -->
    <key>NSSpeechRecognitionUsageDescription</key>
    <string>This app needs speech recognition to convert your speech to text for translation.</string>
    
    <!-- Location permission (optional) -->
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>This app may use location to provide region-specific translations.</string>
    
    <!-- App Transport Security for HTTP requests -->
    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
</dict>
```

2. **Deployment Target**: Update `ios/Runner.xcodeproj/project.pbxproj`:
   - Set `IPHONEOS_DEPLOYMENT_TARGET` to `11.0` or higher

3. **Swift Version**: Ensure Swift 5.0+ is configured in Xcode

### 4. API Configuration

#### Translation API Setup

This app requires translation API keys. You have several options:

##### Option 1: Google Translate API (Recommended)
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable Google Translate API
4. Create API credentials (API Key)
5. Add your API key to the app (see Configuration section)

##### Option 2: Microsoft Translator
1. Go to [Azure Portal](https://portal.azure.com/)
2. Create a Translator resource
3. Get your subscription key and endpoint
4. Configure in the app

##### Option 3: DeepL API
1. Sign up at [DeepL API](https://www.deepl.com/pro-api)
2. Get your authentication key
3. Configure in the app

#### Speech Services Setup

##### Google Speech-to-Text & Text-to-Speech
1. In Google Cloud Console, enable:
   - Speech-to-Text API
   - Text-to-Speech API
2. Create service account and download JSON key file
3. Add to your app configuration

### 5. Configuration

Create a configuration file `lib/config/api_config.dart`:

```dart
class ApiConfig {
  // TODO: Add your API keys here (DO NOT commit to version control)
  static const String googleTranslateApiKey = 'YOUR_GOOGLE_TRANSLATE_API_KEY';
  static const String microsoftTranslatorKey = 'YOUR_MICROSOFT_TRANSLATOR_KEY';
  static const String microsoftTranslatorEndpoint = 'YOUR_MICROSOFT_ENDPOINT';
  static const String deepLApiKey = 'YOUR_DEEPL_API_KEY';
  
  // Speech API configuration
  static const String googleSpeechApiKey = 'YOUR_GOOGLE_SPEECH_API_KEY';
  
  // Default API provider ('google', 'microsoft', 'deepl')
  static const String defaultProvider = 'google';
}
```

**Important**: Add `lib/config/api_config.dart` to your `.gitignore` file to avoid committing API keys.

## Running the App

### Development Mode

```bash
# Run on connected device/emulator
flutter run

# Run on specific device
flutter devices
flutter run -d <device-id>

# Run with hot reload
flutter run --hot
```

### Build for Production

#### Android
```bash
# Build APK
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release
```

#### iOS
```bash
# Build for iOS
flutter build ios --release

# Build IPA file
flutter build ipa --release
```

## Project Structure

```
lib/
├── main.dart                 # App entry point with navigation
├── config/
│   └── api_config.dart       # API keys and configuration
├── screens/
│   ├── home_screen.dart      # Home dashboard
│   ├── text_screen.dart      # Text translation
│   ├── voice_screen.dart     # Voice translation
│   ├── conversation_screen.dart # Real-time conversation
│   ├── image_screen.dart     # Image OCR translation
│   ├── history_screen.dart   # Translation history
│   ├── settings_screen.dart  # App settings
│   └── premium_screen.dart   # Premium features
├── services/
│   ├── translation_service.dart # Translation API integration
│   ├── speech_service.dart      # Speech-to-text/TTS
│   └── storage_service.dart     # Local data storage
├── models/
│   └── translation_model.dart   # Data models
└── widgets/
    └── common_widgets.dart      # Reusable UI components
```

## Key Dependencies

- **provider**: State management
- **http**: HTTP requests for translation APIs
- **image_picker**: Camera and gallery access
- **google_mlkit_text_recognition**: OCR text extraction
- **speech_to_text**: Speech recognition
- **flutter_tts**: Text-to-speech
- **shared_preferences**: Local data storage
- **connectivity_plus**: Network status monitoring

## Implementation Checklist

### Core Features
- [x] App structure and navigation
- [x] UI screens and layouts
- [ ] Translation API integration
- [ ] Speech-to-text implementation
- [ ] Text-to-speech implementation
- [ ] Image OCR integration
- [ ] Local data storage
- [ ] History management

### Advanced Features
- [ ] Offline translation support
- [ ] Cloud synchronization
- [ ] User authentication
- [ ] Premium subscription handling
- [ ] Push notifications
- [ ] Analytics integration

### Platform Optimization
- [ ] Android material design
- [ ] iOS human interface guidelines
- [ ] Performance optimization
- [ ] Battery usage optimization
- [ ] Memory management

## Testing

### Unit Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter test integration_test/
```

### Widget Tests
```bash
flutter test test/widget_test/
```

## Troubleshooting

### Common Issues

1. **ML Kit Setup Issues**
   - Ensure Google Services are properly configured
   - Check minimum SDK version (21+)
   - Verify internet connectivity for first-time model download

2. **Speech Recognition Problems**
   - Check microphone permissions
   - Ensure device has internet connection
   - Verify supported languages

3. **Image Picker Issues**
   - Check camera and storage permissions
   - Ensure FileProvider is configured correctly
   - Test on physical device (camera doesn't work on emulator)

4. **API Rate Limits**
   - Monitor API usage in respective consoles
   - Implement proper error handling
   - Consider caching strategies

### Debug Commands

```bash
# Enable verbose logging
flutter run --verbose

# Check device logs
flutter logs

# Analyze app size
flutter build apk --analyze-size

# Performance profiling
flutter run --profile
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation wiki

## Roadmap

### Version 1.1
- [ ] Offline translation support
- [ ] Additional language support
- [ ] Performance improvements

### Version 1.2
- [ ] Cloud synchronization
- [ ] User accounts
- [ ] Advanced OCR features

### Version 2.0
- [ ] Real-time conversation improvements
- [ ] AI-powered context suggestions
- [ ] Enterprise features

---

**Note**: This is a starter template. Replace placeholder API keys and implement actual functionality based on your requirements. Always follow best practices for API key management and user privacy.