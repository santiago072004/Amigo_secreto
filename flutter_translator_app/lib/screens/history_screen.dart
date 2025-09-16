import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Text', 'Voice', 'Image', 'Conversation'];
  
  // TODO: Replace with actual data from local storage or database
  final List<TranslationHistory> _mockHistory = [
    TranslationHistory(
      id: '1',
      sourceText: 'Hello, how are you?',
      translatedText: 'Hola, ¿cómo estás?',
      sourceLanguage: 'English',
      targetLanguage: 'Spanish',
      type: TranslationType.text,
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      isFavorite: true,
    ),
    TranslationHistory(
      id: '2',
      sourceText: 'Good morning!',
      translatedText: 'Guten Morgen!',
      sourceLanguage: 'English',
      targetLanguage: 'German',
      type: TranslationType.voice,
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      isFavorite: false,
    ),
    TranslationHistory(
      id: '3',
      sourceText: 'Welcome to our restaurant',
      translatedText: 'Bienvenue dans notre restaurant',
      sourceLanguage: 'English',
      targetLanguage: 'French',
      type: TranslationType.image,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isFavorite: false,
    ),
    TranslationHistory(
      id: '4',
      sourceText: 'Thank you very much',
      translatedText: 'Molte grazie',
      sourceLanguage: 'English',
      targetLanguage: 'Italian',
      type: TranslationType.conversation,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      isFavorite: true,
    ),
    TranslationHistory(
      id: '5',
      sourceText: 'Where is the bathroom?',
      translatedText: 'Onde fica o banheiro?',
      sourceLanguage: 'English',
      targetLanguage: 'Portuguese',
      type: TranslationType.text,
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      isFavorite: false,
    ),
  ];

  List<TranslationHistory> get _filteredHistory {
    if (_selectedFilter == 'All') {
      return _mockHistory;
    }
    
    TranslationType? filterType;
    switch (_selectedFilter) {
      case 'Text':
        filterType = TranslationType.text;
        break;
      case 'Voice':
        filterType = TranslationType.voice;
        break;
      case 'Image':
        filterType = TranslationType.image;
        break;
      case 'Conversation':
        filterType = TranslationType.conversation;
        break;
    }
    
    return _mockHistory.where((item) => item.type == filterType).toList();
  }

  void _toggleFavorite(String id) {
    setState(() {
      final index = _mockHistory.indexWhere((item) => item.id == id);
      if (index != -1) {
        _mockHistory[index] = _mockHistory[index].copyWith(
          isFavorite: !_mockHistory[index].isFavorite,
        );
      }
    });
    
    // TODO: Persist favorite status to local storage
  }

  void _deleteItem(String id) {
    setState(() {
      _mockHistory.removeWhere((item) => item.id == id);
    });
    
    // TODO: Remove from local storage
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Translation deleted')),
    );
  }

  void _shareItem(TranslationHistory item) {
    // TODO: Implement actual sharing functionality
    final shareText = '''
Original: ${item.sourceText}
Translation: ${item.translatedText}
${item.sourceLanguage} → ${item.targetLanguage}

Translated with Real-Time Translator
''';
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Share functionality not implemented\n\nContent to share:\n$shareText')),
    );
  }

  void _copyToClipboard(String text) {
    // TODO: Implement actual clipboard functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied: $text')),
    );
  }

  void _clearAllHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear History'),
        content: const Text('Are you sure you want to delete all translation history? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _mockHistory.clear();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All history cleared')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredHistory = _filteredHistory;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translation History'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'clear_all') {
                _clearAllHistory();
              } else if (value == 'export') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Export functionality not implemented')),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'export',
                child: Row(
                  children: [
                    Icon(Icons.download),
                    SizedBox(width: 8),
                    Text('Export History'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'clear_all',
                child: Row(
                  children: [
                    Icon(Icons.delete_forever, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Clear All'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Tabs
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filters.map((filter) {
                  final isSelected = _selectedFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // History List
          Expanded(
            child: filteredHistory.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredHistory.length,
                    itemBuilder: (context, index) {
                      final item = filteredHistory[index];
                      return _buildHistoryItem(item);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            _selectedFilter == 'All' 
                ? 'No translation history yet'
                : 'No $_selectedFilter translations found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start translating to see your history here',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(TranslationHistory item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with type and timestamp
            Row(
              children: [
                Icon(
                  _getTypeIcon(item.type),
                  size: 16,
                  color: _getTypeColor(item.type),
                ),
                const SizedBox(width: 4),
                Text(
                  _getTypeLabel(item.type),
                  style: TextStyle(
                    fontSize: 12,
                    color: _getTypeColor(item.type),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  _formatTimestamp(item.timestamp),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Languages
            Row(
              children: [
                Text(
                  item.sourceLanguage,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.arrow_forward, size: 16),
                Text(
                  item.targetLanguage,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Source text
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                item.sourceText,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 8),

            // Translated text
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                item.translatedText,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 12),

            // Action buttons
            Row(
              children: [
                IconButton(
                  onPressed: () => _toggleFavorite(item.id),
                  icon: Icon(
                    item.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: item.isFavorite ? Colors.red : Colors.grey,
                  ),
                  tooltip: item.isFavorite ? 'Remove from favorites' : 'Add to favorites',
                ),
                IconButton(
                  onPressed: () => _copyToClipboard(item.translatedText),
                  icon: const Icon(Icons.copy),
                  tooltip: 'Copy translation',
                ),
                IconButton(
                  onPressed: () => _shareItem(item),
                  icon: const Icon(Icons.share),
                  tooltip: 'Share',
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => _deleteItem(item.id),
                  icon: const Icon(Icons.delete, color: Colors.red),
                  tooltip: 'Delete',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTypeIcon(TranslationType type) {
    switch (type) {
      case TranslationType.text:
        return Icons.text_fields;
      case TranslationType.voice:
        return Icons.mic;
      case TranslationType.image:
        return Icons.camera_alt;
      case TranslationType.conversation:
        return Icons.chat;
    }
  }

  Color _getTypeColor(TranslationType type) {
    switch (type) {
      case TranslationType.text:
        return Colors.blue;
      case TranslationType.voice:
        return Colors.green;
      case TranslationType.image:
        return Colors.purple;
      case TranslationType.conversation:
        return Colors.orange;
    }
  }

  String _getTypeLabel(TranslationType type) {
    switch (type) {
      case TranslationType.text:
        return 'TEXT';
      case TranslationType.voice:
        return 'VOICE';
      case TranslationType.image:
        return 'IMAGE';
      case TranslationType.conversation:
        return 'CONVERSATION';
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}

enum TranslationType { text, voice, image, conversation }

class TranslationHistory {
  final String id;
  final String sourceText;
  final String translatedText;
  final String sourceLanguage;
  final String targetLanguage;
  final TranslationType type;
  final DateTime timestamp;
  final bool isFavorite;

  TranslationHistory({
    required this.id,
    required this.sourceText,
    required this.translatedText,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.type,
    required this.timestamp,
    required this.isFavorite,
  });

  TranslationHistory copyWith({
    String? id,
    String? sourceText,
    String? translatedText,
    String? sourceLanguage,
    String? targetLanguage,
    TranslationType? type,
    DateTime? timestamp,
    bool? isFavorite,
  }) {
    return TranslationHistory(
      id: id ?? this.id,
      sourceText: sourceText ?? this.sourceText,
      translatedText: translatedText ?? this.translatedText,
      sourceLanguage: sourceLanguage ?? this.sourceLanguage,
      targetLanguage: targetLanguage ?? this.targetLanguage,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}