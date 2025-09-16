import 'package:flutter/material.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  bool _isPremium = false; // TODO: Load from user subscription status
  int _selectedPlanIndex = 1; // Default to monthly plan

  final List<PremiumPlan> _plans = [
    PremiumPlan(
      name: 'Weekly',
      price: '\$2.99',
      duration: 'per week',
      savings: null,
      popular: false,
    ),
    PremiumPlan(
      name: 'Monthly',
      price: '\$9.99',
      duration: 'per month',
      savings: '17% off',
      popular: true,
    ),
    PremiumPlan(
      name: 'Yearly',
      price: '\$79.99',
      duration: 'per year',
      savings: '33% off',
      popular: false,
    ),
  ];

  final List<PremiumFeature> _premiumFeatures = [
    PremiumFeature(
      icon: Icons.translate,
      title: 'Unlimited Translations',
      description: 'Translate as much text as you want without limits',
      isFree: false,
    ),
    PremiumFeature(
      icon: Icons.language,
      title: 'All Languages',
      description: 'Access to 100+ languages including rare dialects',
      isFree: false,
    ),
    PremiumFeature(
      icon: Icons.camera_alt,
      title: 'Advanced OCR',
      description: 'Enhanced image text recognition with better accuracy',
      isFree: false,
    ),
    PremiumFeature(
      icon: Icons.mic,
      title: 'Real-time Voice',
      description: 'Continuous voice translation without interruptions',
      isFree: false,
    ),
    PremiumFeature(
      icon: Icons.cloud_sync,
      title: 'Cloud Sync',
      description: 'Sync your history across all devices',
      isFree: false,
    ),
    PremiumFeature(
      icon: Icons.download,
      title: 'Offline Mode',
      description: 'Download language packs for offline translation',
      isFree: false,
    ),
    PremiumFeature(
      icon: Icons.ads_click_off,
      title: 'Ad-Free Experience',
      description: 'Enjoy the app without any advertisements',
      isFree: false,
    ),
    PremiumFeature(
      icon: Icons.priority_high,
      title: 'Priority Support',
      description: 'Get faster response times for support requests',
      isFree: false,
    ),
  ];

  final List<PremiumFeature> _freeFeatures = [
    PremiumFeature(
      icon: Icons.text_fields,
      title: 'Basic Text Translation',
      description: 'Translate text between major languages',
      isFree: true,
    ),
    PremiumFeature(
      icon: Icons.history,
      title: 'Limited History',
      description: 'Save up to 50 recent translations',
      isFree: true,
    ),
    PremiumFeature(
      icon: Icons.photo_camera,
      title: 'Basic OCR',
      description: 'Extract text from images (10 per day)',
      isFree: true,
    ),
    PremiumFeature(
      icon: Icons.volume_up,
      title: 'Text-to-Speech',
      description: 'Listen to translations in supported languages',
      isFree: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (_isPremium)
            TextButton(
              onPressed: _showManageSubscription,
              child: const Text('Manage'),
            ),
        ],
      ),
      body: _isPremium ? _buildPremiumUserView() : _buildUpgradeView(),
    );
  }

  Widget _buildUpgradeView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Section
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue[400]!,
                  Colors.purple[400]!,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  const Icon(
                    Icons.star,
                    size: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Unlock Premium Features',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Get unlimited access to all translation features and remove ads',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // Pricing Plans
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose Your Plan',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ...List.generate(_plans.length, (index) {
                  final plan = _plans[index];
                  final isSelected = _selectedPlanIndex == index;
                  
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPlanIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.grey[300]!,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: isSelected ? Colors.blue[50] : Colors.white,
                      ),
                      child: Stack(
                        children: [
                          if (plan.popular)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'POPULAR',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                Radio<int>(
                                  value: index,
                                  groupValue: _selectedPlanIndex,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _selectedPlanIndex = value!;
                                    });
                                  },
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        plan.name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${plan.price} ${plan.duration}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      if (plan.savings != null)
                                        Text(
                                          plan.savings!,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),

          // Premium Features
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Premium Features',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ..._premiumFeatures.map((feature) => _buildFeatureItem(feature)),
              ],
            ),
          ),

          // Free Features
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Free Features (Always Available)',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ..._freeFeatures.map((feature) => _buildFeatureItem(feature)),
              ],
            ),
          ),

          // Subscribe Button
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _subscribeToPremium,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text('Start ${_plans[_selectedPlanIndex].name} Plan'),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _restorePurchases,
                  child: const Text('Restore Purchases'),
                ),
                const SizedBox(height: 8),
                Text(
                  'By subscribing, you agree to our Terms of Service and Privacy Policy. '
                  'Subscription automatically renews unless auto-renew is turned off.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumUserView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Premium Status Card
          Card(
            color: Colors.green[50],
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Icon(
                    Icons.verified,
                    size: 64,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Premium Active',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Thank you for supporting Real-Time Translator!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Monthly Plan • Renews Dec 15, 2024',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Active Features
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Your Premium Features',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ..._premiumFeatures.map((feature) => _buildFeatureItem(feature)),

          const SizedBox(height: 32),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _showManageSubscription,
                  child: const Text('Manage Subscription'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _shareApp,
                  child: const Text('Share App'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(PremiumFeature feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: feature.isFree ? Colors.grey[100] : Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              feature.icon,
              size: 24,
              color: feature.isFree ? Colors.grey[600] : Colors.blue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  feature.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          if (!feature.isFree)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'PRO',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _subscribeToPremium() {
    // TODO: Implement actual subscription logic using in-app purchases
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Subscription'),
        content: Text(
          'Subscribe to ${_plans[_selectedPlanIndex].name} plan for ${_plans[_selectedPlanIndex].price}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _isPremium = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Subscription activated! (Demo mode)')),
              );
            },
            child: const Text('Subscribe'),
          ),
        ],
      ),
    );
  }

  void _restorePurchases() {
    // TODO: Implement actual purchase restoration
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No previous purchases found')),
    );
  }

  void _showManageSubscription() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Manage Subscription'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Plan: Monthly Premium'),
            Text('Next Billing: December 15, 2024'),
            Text('Amount: \$9.99'),
            SizedBox(height: 16),
            Text('To cancel or modify your subscription, visit your app store settings.'),
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
                const SnackBar(content: Text('Opening app store settings...')),
              );
            },
            child: const Text('App Store Settings'),
          ),
        ],
      ),
    );
  }

  void _shareApp() {
    // TODO: Implement actual sharing functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality not implemented')),
    );
  }
}

class PremiumPlan {
  final String name;
  final String price;
  final String duration;
  final String? savings;
  final bool popular;

  PremiumPlan({
    required this.name,
    required this.price,
    required this.duration,
    this.savings,
    required this.popular,
  });
}

class PremiumFeature {
  final IconData icon;
  final String title;
  final String description;
  final bool isFree;

  PremiumFeature({
    required this.icon,
    required this.title,
    required this.description,
    required this.isFree,
  });
}