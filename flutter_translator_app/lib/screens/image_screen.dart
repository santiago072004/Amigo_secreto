import 'package:flutter/material.dart';
import 'dart:io';
// TODO: Uncomment these imports after adding the packages
// import 'package:image_picker/image_picker.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  File? _selectedImage;
  String _extractedText = '';
  String _translatedText = '';
  bool _isProcessing = false;
  String _sourceLanguage = 'Auto-detect';
  String _targetLanguage = 'English';

  // TODO: Initialize ML Kit text recognizer
  // final TextRecognizer _textRecognizer = TextRecognizer();
  // final ImagePicker _imagePicker = ImagePicker();

  final List<String> _languages = [
    'Auto-detect',
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

  @override
  void dispose() {
    // TODO: Dispose of ML Kit resources
    // _textRecognizer.close();
    super.dispose();
  }

  Future<void> _pickImageFromCamera() async {
    try {
      // TODO: Use actual image picker
      // final XFile? image = await _imagePicker.pickImage(
      //   source: ImageSource.camera,
      //   maxWidth: 1800,
      //   maxHeight: 1800,
      //   imageQuality: 85,
      // );
      
      // if (image != null) {
      //   setState(() {
      //     _selectedImage = File(image.path);
      //     _extractedText = '';
      //     _translatedText = '';
      //   });
      //   _processImage();
      // }

      // Mock image selection
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera functionality requires actual image_picker package')),
      );
      
    } catch (e) {
      _showError('Failed to pick image from camera: $e');
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      // TODO: Use actual image picker
      // final XFile? image = await _imagePicker.pickImage(
      //   source: ImageSource.gallery,
      //   maxWidth: 1800,
      //   maxHeight: 1800,
      //   imageQuality: 85,
      // );
      
      // if (image != null) {
      //   setState(() {
      //     _selectedImage = File(image.path);
      //     _extractedText = '';
      //     _translatedText = '';
      //   });
      //   _processImage();
      // }

      // Mock image selection
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gallery functionality requires actual image_picker package')),
      );
      
    } catch (e) {
      _showError('Failed to pick image from gallery: $e');
    }
  }

  Future<void> _processImage() async {
    if (_selectedImage == null) return;

    setState(() {
      _isProcessing = true;
      _extractedText = '';
      _translatedText = '';
    });

    try {
      // TODO: Use actual ML Kit text recognition
      // final InputImage inputImage = InputImage.fromFile(_selectedImage!);
      // final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
      
      // String text = '';
      // for (TextBlock block in recognizedText.blocks) {
      //   text += '${block.text}\n';
      // }

      // Mock text extraction
      await Future.delayed(const Duration(seconds: 2));
      const mockExtractedText = '''Sample extracted text:
Hello World!
This is a demo of OCR text recognition.
The actual implementation would use ML Kit to extract text from the selected image.''';

      setState(() {
        _extractedText = mockExtractedText.trim();
      });

      // Auto-translate if text was extracted
      if (_extractedText.isNotEmpty && _sourceLanguage != _targetLanguage) {
        await _translateExtractedText();
      }

    } catch (e) {
      _showError('Failed to process image: $e');
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<void> _translateExtractedText() async {
    if (_extractedText.isEmpty) return;

    try {
      // TODO: Implement actual translation API call
      // Similar to text_screen.dart implementation
      
      await Future.delayed(const Duration(seconds: 1));
      
      setState(() {
        _translatedText = 'Mock translation of extracted text from ${_sourceLanguage == 'Auto-detect' ? 'detected language' : _sourceLanguage} to $_targetLanguage:\n\n$_extractedText';
      });

    } catch (e) {
      _showError('Translation failed: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _clearAll() {
    setState(() {
      _selectedImage = null;
      _extractedText = '';
      _translatedText = '';
    });
  }

  void _retryProcessing() {
    if (_selectedImage != null) {
      _processImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Translation (OCR)'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (_selectedImage != null)
            IconButton(
              onPressed: _clearAll,
              icon: const Icon(Icons.clear),
              tooltip: 'Clear all',
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language Selection
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _sourceLanguage,
                    decoration: const InputDecoration(
                      labelText: 'Source Language',
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
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _targetLanguage,
                    decoration: const InputDecoration(
                      labelText: 'Target Language',
                      border: OutlineInputBorder(),
                    ),
                    items: _languages.skip(1).map((String language) {
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
                        // Auto-translate if we have extracted text
                        if (_extractedText.isNotEmpty) {
                          _translateExtractedText();
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Image Selection Buttons
            if (_selectedImage == null) ...[
              const Text(
                'Select an image to extract and translate text',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _pickImageFromCamera,
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Take Photo'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _pickImageFromGallery,
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Choose from Gallery'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Instructions Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.info, color: Colors.blue),
                          SizedBox(width: 8),
                          Text(
                            'How it works',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text('1. Take a photo or select an image from your gallery'),
                      const Text('2. The app will extract text using ML Kit OCR'),
                      const Text('3. Extracted text will be automatically translated'),
                      const Text('4. You can save or share the results'),
                      const SizedBox(height: 12),
                      Text(
                        'Tip: For best results, ensure text is clear and well-lit',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // Selected Image Display
            if (_selectedImage != null) ...[
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Selected Image',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Text('Error loading image'),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: _retryProcessing,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Reprocess'),
                          ),
                          const SizedBox(width: 16),
                          OutlinedButton.icon(
                            onPressed: _pickImageFromGallery,
                            icon: const Icon(Icons.edit),
                            label: const Text('Change Image'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Processing Indicator
            if (_isProcessing) ...[
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Processing Image...',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Extracting text using ML Kit OCR'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Extracted Text
            if (_extractedText.isNotEmpty) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.text_fields, color: Colors.green),
                          SizedBox(width: 8),
                          Text(
                            'Extracted Text',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _extractedText,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              // TODO: Copy to clipboard
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Copied to clipboard')),
                              );
                            },
                            icon: const Icon(Icons.copy),
                            label: const Text('Copy'),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton.icon(
                            onPressed: _translateExtractedText,
                            icon: const Icon(Icons.translate),
                            label: const Text('Translate'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Translated Text
            if (_translatedText.isNotEmpty) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.translate, color: Colors.blue),
                          SizedBox(width: 8),
                          Text(
                            'Translation',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          border: Border.all(color: Colors.blue[200]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _translatedText,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              // TODO: Copy translation to clipboard
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Translation copied to clipboard')),
                              );
                            },
                            icon: const Icon(Icons.copy),
                            label: const Text('Copy'),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton.icon(
                            onPressed: () {
                              // TODO: Text-to-speech for translation
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Text-to-speech not implemented')),
                              );
                            },
                            icon: const Icon(Icons.volume_up),
                            label: const Text('Listen'),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton.icon(
                            onPressed: () {
                              // TODO: Save to history
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Saved to history')),
                              );
                            },
                            icon: const Icon(Icons.bookmark),
                            label: const Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}