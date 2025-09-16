import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/text_screen.dart';
import 'screens/voice_screen.dart';
import 'screens/conversation_screen.dart';
import 'screens/image_screen.dart';
import 'screens/history_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/premium_screen.dart';

void main() {
  runApp(const TranslatorApp());
}

class TranslatorApp extends StatelessWidget {
  const TranslatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // TODO: Add your state providers here
        // Example: ChangeNotifierProvider(create: (_) => TranslationProvider()),
      ],
      child: MaterialApp(
        title: 'Real-Time Translator',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const HomeShell(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _selectedIndex = 0;

  // Navigation screens
  final List<Widget> _screens = [
    const HomeScreen(),
    const TextScreen(),
    const VoiceScreen(),
    const ConversationScreen(),
    const ImageScreen(),
    const HistoryScreen(),
    const SettingsScreen(),
    const PremiumScreen(),
  ];

  // Navigation items with icons and labels
  final List<NavigationItem> _navigationItems = [
    NavigationItem(icon: Icons.home, label: 'Home'),
    NavigationItem(icon: Icons.text_fields, label: 'Text'),
    NavigationItem(icon: Icons.mic, label: 'Voice'),
    NavigationItem(icon: Icons.chat, label: 'Chat'),
    NavigationItem(icon: Icons.camera_alt, label: 'Image'),
    NavigationItem(icon: Icons.history, label: 'History'),
    NavigationItem(icon: Icons.settings, label: 'Settings'),
    NavigationItem(icon: Icons.star, label: 'Premium'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex < 5 ? _selectedIndex : 0,
        onTap: (index) {
          if (index < 5) {
            _onItemTapped(index);
          }
        },
        items: _navigationItems
            .take(5)
            .map((item) => BottomNavigationBarItem(
                  icon: Icon(item.icon),
                  label: item.label,
                ))
            .toList(),
      ),
      drawer: _selectedIndex >= 5
          ? null
          : Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(
                      'Translator App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ..._navigationItems.skip(5).map((item) {
                    int index = _navigationItems.indexOf(item);
                    return ListTile(
                      leading: Icon(item.icon),
                      title: Text(item.label),
                      selected: _selectedIndex == index,
                      onTap: () {
                        _onItemTapped(index);
                        Navigator.pop(context);
                      },
                    );
                  }),
                ],
              ),
            ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;

  NavigationItem({required this.icon, required this.label});
}