import 'package:flutter/material.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({super.key});

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  String _sourceLanguage = 'English';
  String _targetLanguage = 'Spanish';
  bool _isTranslating = false;

  // TODO: Replace with actual supported languages from your translation API
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
  ];

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  Future<void> _translateText() async {
    if (_inputController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter text to translate')),
      );
      return;
    }

    setState(() {
      _isTranslating = true;
    });

    try {
      // TODO: Implement actual translation API call
      // Example using HTTP package:
      // final response = await http.post(
      //   Uri.parse('YOUR_TRANSLATION_API_ENDPOINT'),
      //   headers: {
      //     'Authorization': 'Bearer YOUR_API_KEY',
      //     'Content-Type': 'application/json',
      //   },
      //   body: json.encode({
      //     'text': _inputController.text,
      //     'source': _sourceLanguage,
      //     'target': _targetLanguage,
      //   }),
      // );
      
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock translation result
      _outputController.text = 'Mock translation of "${_inputController.text}" from $_sourceLanguage to $_targetLanguage';
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Translation failed: $e')),
      );
    } finally {
      setState(() {
        _isTranslating = false;
      });
    }
  }

  void _swapLanguages() {
    setState(() {
      final temp = _sourceLanguage;
      _sourceLanguage = _targetLanguage;
      _targetLanguage = temp;
      
      // Swap text content too
      final tempText = _inputController.text;
      _inputController.text = _outputController.text;
      _outputController.text = tempText;
    });
  }

  void _clearText() {
    _inputController.clear();
    _outputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Translation'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: _clearText,
            icon: const Icon(Icons.clear),
            tooltip: 'Clear text',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Language Selection Row
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _sourceLanguage,
                    decoration: const InputDecoration(
                      labelText: 'From',
                      border: OutlineInputBorder(),
                    ),
                    items: _languages.map((String language) {
                      return DropdownMenuItem<String>(
                        value: language,
                        child: Text(language),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _sourceLanguage = newValue;
                        });
                      }
                    },
                  ),
                ),
                IconButton(
                  onPressed: _swapLanguages,
                  icon: const Icon(Icons.swap_horiz),
                  tooltip: 'Swap languages',
                ),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _targetLanguage,
                    decoration: const InputDecoration(
                      labelText: 'To',
                      border: OutlineInputBorder(),
                    ),
                    items: _languages.map((String language) {
                      return DropdownMenuItem<String>(
                        value: language,
                        child: Text(language),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _targetLanguage = newValue;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Input Text Field
            Expanded(
              flex: 2,
              child: TextField(
                controller: _inputController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: 'Enter text to translate...',
                  border: const OutlineInputBorder(),
                  labelText: 'Source Text',
                  suffix: _inputController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () => _inputController.clear(),
                          icon: const Icon(Icons.clear, size: 18),
                        )
                      : null,
                ),
                onChanged: (value) {
                  setState(() {}); // Rebuild to show/hide clear button
                },
              ),
            ),
            const SizedBox(height: 16),

            // Translate Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isTranslating ? null : _translateText,
                icon: _isTranslating
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.translate),
                label: Text(_isTranslating ? 'Translating...' : 'Translate'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Output Text Field
            Expanded(
              flex: 2,
              child: TextField(
                controller: _outputController,
                maxLines: null,
                expands: true,
                readOnly: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: 'Translation will appear here...',
                  border: const OutlineInputBorder(),
                  labelText: 'Translation',
                  suffix: _outputController.text.isNotEmpty
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                // TODO: Implement copy to clipboard
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Copied to clipboard'),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.copy, size: 18),
                              tooltip: 'Copy translation',
                            ),
                            IconButton(
                              onPressed: () {
                                // TODO: Implement text-to-speech for translation
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Text-to-speech not implemented'),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.volume_up, size: 18),
                              tooltip: 'Listen to translation',
                            ),
                          ],
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Action Buttons Row
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Save translation to history
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Saved to history')),
                      );
                    },
                    icon: const Icon(Icons.bookmark),
                    label: const Text('Save'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Share translation
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Share functionality not implemented')),
                      );
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('Share'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}