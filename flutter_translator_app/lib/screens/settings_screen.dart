import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // TODO: Load these from shared preferences or local storage
  bool _autoTranslate = true;
  bool _saveHistory = true;
  bool _vibrationFeedback = true;
  bool _soundEffects = true;
  String _defaultSourceLanguage = 'English';
  String _defaultTargetLanguage = 'Spanish';
  String _theme = 'System';
  double _speechRate = 0.5;
  double _speechPitch = 1.0;
  double _speechVolume = 1.0;

  final List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Italian',
    'Portuguese',
    'Russian',
    'Chinese',
    'Japanese',
    'Korean',
    'Arabic',
  ];

  final List<String> _themes = ['System', 'Light', 'Dark'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Translation Settings
          _buildSectionHeader('Translation'),
          _buildSwitchTile(
            title: 'Auto-translate',
            subtitle: 'Automatically translate text in conversation mode',
            value: _autoTranslate,
            onChanged: (value) {
              setState(() {
                _autoTranslate = value;
              });
              // TODO: Save to preferences
            },
          ),
          _buildLanguageDropdown(
            title: 'Default source language',
            value: _defaultSourceLanguage,
            onChanged: (value) {
              setState(() {
                _defaultSourceLanguage = value!;
              });
              // TODO: Save to preferences
            },
          ),
          _buildLanguageDropdown(
            title: 'Default target language',
            value: _defaultTargetLanguage,
            onChanged: (value) {
              setState(() {
                _defaultTargetLanguage = value!;
              });
              // TODO: Save to preferences
            },
          ),

          const SizedBox(height: 24),

          // Speech Settings
          _buildSectionHeader('Speech & Audio'),
          _buildSliderTile(
            title: 'Speech rate',
            subtitle: 'Adjust text-to-speech speed',
            value: _speechRate,
            min: 0.1,
            max: 1.0,
            divisions: 9,
            onChanged: (value) {
              setState(() {
                _speechRate = value;
              });
              // TODO: Save to preferences and update TTS settings
            },
          ),
          _buildSliderTile(
            title: 'Speech pitch',
            subtitle: 'Adjust text-to-speech pitch',
            value: _speechPitch,
            min: 0.5,
            max: 2.0,
            divisions: 15,
            onChanged: (value) {
              setState(() {
                _speechPitch = value;
              });
              // TODO: Save to preferences and update TTS settings
            },
          ),
          _buildSliderTile(
            title: 'Speech volume',
            subtitle: 'Adjust text-to-speech volume',
            value: _speechVolume,
            min: 0.0,
            max: 1.0,
            divisions: 10,
            onChanged: (value) {
              setState(() {
                _speechVolume = value;
              });
              // TODO: Save to preferences and update TTS settings
            },
          ),
          _buildSwitchTile(
            title: 'Sound effects',
            subtitle: 'Play sounds for button taps and notifications',
            value: _soundEffects,
            onChanged: (value) {
              setState(() {
                _soundEffects = value;
              });
              // TODO: Save to preferences
            },
          ),

          const SizedBox(height: 24),

          // Privacy & Data
          _buildSectionHeader('Privacy & Data'),
          _buildSwitchTile(
            title: 'Save translation history',
            subtitle: 'Store translations locally for quick access',
            value: _saveHistory,
            onChanged: (value) {
              setState(() {
                _saveHistory = value;
              });
              // TODO: Save to preferences
            },
          ),
          _buildListTile(
            title: 'Clear all data',
            subtitle: 'Delete all saved translations and preferences',
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            onTap: _showClearDataDialog,
          ),
          _buildListTile(
            title: 'Export data',
            subtitle: 'Export your translation history',
            leading: const Icon(Icons.download),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Export functionality not implemented')),
              );
            },
          ),

          const SizedBox(height: 24),

          // Appearance
          _buildSectionHeader('Appearance'),
          _buildDropdownTile(
            title: 'Theme',
            subtitle: 'Choose your preferred theme',
            value: _theme,
            items: _themes,
            onChanged: (value) {
              setState(() {
                _theme = value!;
              });
              // TODO: Apply theme change and save to preferences
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Theme changed to $value')),
              );
            },
          ),
          _buildSwitchTile(
            title: 'Vibration feedback',
            subtitle: 'Vibrate on button taps and notifications',
            value: _vibrationFeedback,
            onChanged: (value) {
              setState(() {
                _vibrationFeedback = value;
              });
              // TODO: Save to preferences
            },
          ),

          const SizedBox(height: 24),

          // API Configuration
          _buildSectionHeader('API Configuration'),
          _buildListTile(
            title: 'Translation API',
            subtitle: 'Configure translation service settings',
            leading: const Icon(Icons.api),
            onTap: _showApiConfigDialog,
          ),
          _buildListTile(
            title: 'Speech services',
            subtitle: 'Configure speech-to-text and text-to-speech',
            leading: const Icon(Icons.settings_voice),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Speech service configuration not implemented')),
              );
            },
          ),

          const SizedBox(height: 24),

          // About
          _buildSectionHeader('About'),
          _buildListTile(
            title: 'App version',
            subtitle: '1.0.0+1',
            leading: const Icon(Icons.info),
            onTap: _showAboutDialog,
          ),
          _buildListTile(
            title: 'Privacy policy',
            subtitle: 'Read our privacy policy',
            leading: const Icon(Icons.privacy_tip),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Privacy policy not implemented')),
              );
            },
          ),
          _buildListTile(
            title: 'Terms of service',
            subtitle: 'Read our terms of service',
            leading: const Icon(Icons.description),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Terms of service not implemented')),
              );
            },
          ),
          _buildListTile(
            title: 'Send feedback',
            subtitle: 'Help us improve the app',
            leading: const Icon(Icons.feedback),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Feedback functionality not implemented')),
              );
            },
          ),

          const SizedBox(height: 24),

          // Test Speech Button
          Center(
            child: ElevatedButton.icon(
              onPressed: _testSpeechSettings,
              icon: const Icon(Icons.volume_up),
              label: const Text('Test Speech Settings'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required String subtitle,
    required Widget leading,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: leading,
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildLanguageDropdown({
    required String title,
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return ListTile(
      title: Text(title),
      trailing: DropdownButton<String>(
        value: value,
        items: _languages.map((String language) {
          return DropdownMenuItem<String>(
            value: language,
            child: Text(language),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDropdownTile({
    required String title,
    required String subtitle,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: DropdownButton<String>(
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSliderTile({
    required String title,
    required String subtitle,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          subtitle: Text('$subtitle (${value.toStringAsFixed(1)})'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  void _showClearDataDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text(
          'This will permanently delete all your translation history, saved preferences, and other app data. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement actual data clearing
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All data cleared')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  void _showApiConfigDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('API Configuration'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Configure your translation API settings:'),
            SizedBox(height: 16),
            Text('• Google Translate API'),
            Text('• Microsoft Translator'),
            Text('• DeepL API'),
            Text('• Amazon Translate'),
            SizedBox(height: 16),
            Text(
              'Note: You need to provide your own API keys for translation services.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('API configuration not implemented')),
              );
            },
            child: const Text('Configure'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Real-Time Translator',
      applicationVersion: '1.0.0+1',
      applicationIcon: const Icon(Icons.translate, size: 64),
      children: [
        const Text(
          'A powerful mobile app for real-time translation with support for text, voice, conversation, and image translation.',
        ),
        const SizedBox(height: 16),
        const Text('Features:'),
        const Text('• Text translation'),
        const Text('• Voice translation'),
        const Text('• Real-time conversation'),
        const Text('• Image text recognition (OCR)'),
        const Text('• Translation history'),
        const Text('• Multiple language support'),
      ],
    );
  }

  void _testSpeechSettings() {
    // TODO: Use actual TTS with current settings
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Testing speech with rate: ${_speechRate.toStringAsFixed(1)}, '
          'pitch: ${_speechPitch.toStringAsFixed(1)}, '
          'volume: ${_speechVolume.toStringAsFixed(1)}',
        ),
      ),
    );
  }
}