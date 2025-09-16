import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ConversationMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  
  String _userLanguage = 'English';
  String _partnerLanguage = 'Spanish';
  bool _isTranslating = false;
  bool _autoTranslate = true;

  final Map<String, String> _languages = {
    'English': 'en',
    'Spanish': 'es',
    'French': 'fr',
    'German': 'de',
    'Italian': 'it',
    'Portuguese': 'pt',
    'Russian': 'ru',
    'Chinese': 'zh',
    'Japanese': 'ja',
    'Korean': 'ko',
  };

  @override
  void initState() {
    super.initState();
    _addSystemMessage('Conversation started. Messages will be automatically translated.');
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addSystemMessage(String message) {
    setState(() {
      _messages.add(ConversationMessage(
        text: message,
        isUser: false,
        isSystem: true,
        timestamp: DateTime.now(),
      ));
    });
    _scrollToBottom();
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    // Add user message
    final userMessage = ConversationMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
      _isTranslating = true;
    });

    _messageController.clear();
    _scrollToBottom();

    if (_autoTranslate) {
      // Translate the message
      final translatedText = await _translateMessage(text, _userLanguage, _partnerLanguage);
      
      // Add translated message
      final translatedMessage = ConversationMessage(
        text: translatedText,
        originalText: text,
        isUser: true,
        isTranslated: true,
        timestamp: DateTime.now(),
        targetLanguage: _partnerLanguage,
      );

      setState(() {
        _messages.add(translatedMessage);
        _isTranslating = false;
      });
      _scrollToBottom();
    } else {
      setState(() {
        _isTranslating = false;
      });
    }

    // Simulate partner response (for demo purposes)
    await Future.delayed(const Duration(seconds: 2));
    _simulatePartnerResponse();
  }

  Future<String> _translateMessage(String text, String from, String to) async {
    // TODO: Implement actual translation API call
    // Example:
    // final response = await http.post(
    //   Uri.parse('YOUR_TRANSLATION_API_ENDPOINT'),
    //   headers: {'Authorization': 'Bearer YOUR_API_KEY'},
    //   body: json.encode({
    //     'text': text,
    //     'source': _languages[from],
    //     'target': _languages[to],
    //   }),
    // );

    await Future.delayed(const Duration(seconds: 1));
    return 'Translated: "$text" from $from to $to';
  }

  void _simulatePartnerResponse() {
    final responses = [
      'Hola, ¿cómo estás?',
      '¡Qué interesante!',
      'No entiendo completamente.',
      'Gracias por la información.',
      '¿Puedes repetir eso?',
    ];

    final randomResponse = responses[DateTime.now().millisecond % responses.length];

    // Add partner message in their language
    final partnerMessage = ConversationMessage(
      text: randomResponse,
      isUser: false,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(partnerMessage);
    });
    _scrollToBottom();

    // Auto-translate partner's message if enabled
    if (_autoTranslate) {
      Future.delayed(const Duration(milliseconds: 500), () async {
        final translatedText = await _translateMessage(randomResponse, _partnerLanguage, _userLanguage);
        
        final translatedPartnerMessage = ConversationMessage(
          text: translatedText,
          originalText: randomResponse,
          isUser: false,
          isTranslated: true,
          timestamp: DateTime.now(),
          targetLanguage: _userLanguage,
        );

        setState(() {
          _messages.add(translatedPartnerMessage);
        });
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _swapLanguages() {
    setState(() {
      final temp = _userLanguage;
      _userLanguage = _partnerLanguage;
      _partnerLanguage = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversation'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _autoTranslate = !_autoTranslate;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _autoTranslate ? 'Auto-translate enabled' : 'Auto-translate disabled',
                  ),
                ),
              );
            },
            icon: Icon(
              _autoTranslate ? Icons.translate : Icons.translate_outlined,
            ),
            tooltip: 'Toggle auto-translate',
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'clear') {
                setState(() {
                  _messages.clear();
                });
                _addSystemMessage('Conversation cleared.');
              } else if (value == 'settings') {
                _showLanguageSettings();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.language),
                    SizedBox(width: 8),
                    Text('Language Settings'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.clear),
                    SizedBox(width: 8),
                    Text('Clear Chat'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Language indicator
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You: $_userLanguage',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: _swapLanguages,
                  child: const Icon(Icons.swap_horiz, color: Colors.blue),
                ),
                const SizedBox(width: 16),
                Text(
                  'Partner: $_partnerLanguage',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Messages list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),

          // Translation indicator
          if (_isTranslating)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 8),
                  Text('Translating...'),
                ],
              ),
            ),

          // Message input
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -1),
                  blurRadius: 1,
                  color: Colors.grey[300]!,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: 'Type a message in $_userLanguage...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  mini: true,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ConversationMessage message) {
    if (message.isSystem) {
      return Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            message.text,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser) const SizedBox(width: 40),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: message.isUser
                    ? (message.isTranslated ? Colors.blue[100] : Colors.blue)
                    : (message.isTranslated ? Colors.grey[200] : Colors.grey[300]),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.isTranslated && message.originalText != null) ...[
                    Text(
                      message.originalText!,
                      style: TextStyle(
                        color: message.isUser ? Colors.white70 : Colors.black54,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Divider(
                      height: 1,
                      color: message.isUser ? Colors.white30 : Colors.black26,
                    ),
                    const SizedBox(height: 4),
                  ],
                  Text(
                    message.text,
                    style: TextStyle(
                      color: message.isUser && !message.isTranslated ? Colors.white : Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                  if (message.isTranslated && message.targetLanguage != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Translated to ${message.targetLanguage}',
                      style: TextStyle(
                        color: message.isUser ? Colors.white60 : Colors.black45,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (message.isUser) const SizedBox(width: 40),
        ],
      ),
    );
  }

  void _showLanguageSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Language Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: _userLanguage,
              decoration: const InputDecoration(labelText: 'Your Language'),
              items: _languages.keys.map((language) {
                return DropdownMenuItem(value: language, child: Text(language));
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _userLanguage = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _partnerLanguage,
              decoration: const InputDecoration(labelText: 'Partner Language'),
              items: _languages.keys.map((language) {
                return DropdownMenuItem(value: language, child: Text(language));
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _partnerLanguage = value;
                  });
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _addSystemMessage('Languages updated to $_userLanguage ↔ $_partnerLanguage');
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

class ConversationMessage {
  final String text;
  final String? originalText;
  final bool isUser;
  final bool isSystem;
  final bool isTranslated;
  final DateTime timestamp;
  final String? targetLanguage;

  ConversationMessage({
    required this.text,
    this.originalText,
    required this.isUser,
    this.isSystem = false,
    this.isTranslated = false,
    required this.timestamp,
    this.targetLanguage,
  });
}