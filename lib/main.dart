import 'package:flutter/material.dart';

void main() {
  runApp(const LibraryApp());
}

class LibraryApp extends StatelessWidget {
  const LibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
        title: 'مكتبة الشيخ أحمد الصعبي',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Arial',
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6B4226),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        home: const MainNavigation(),
      ),
    );
  }
}

// ============ شريط التنقل الرئيسي ============
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    PlaceholderScreen(title: 'الكتب', icon: Icons.menu_book),
    PlaceholderScreen(title: 'الوسائط', icon: Icons.play_circle_outline),
    PlaceholderScreen(title: 'الملف الشخصي', icon: Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: const Color(0xFF6B4226),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'الكتب'),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle_outline), label: 'الوسائط'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الملف الشخصي'),
        ],
      ),
    );
  }
}

// ============ الشاشة الرئيسية ============
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF3E2723), Color(0xFF1B0F0A)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // شريط بحث بسيط
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.white70),
                    SizedBox(width: 10),
                    Text('بحث', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'مكتبة الشيخ الدكتور أحمد الصعبي',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              // إطار دائري لصورة الشيخ (مؤقت لحد ما تحط صورة حقيقية)
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD4AF37), width: 4),
                ),
                child: const CircleAvatar(
                  backgroundColor: Color(0xFF4E342E),
                  child: Icon(Icons.person, size: 90, color: Colors.white54),
                ),
              ),
              const SizedBox(height: 40),
              // زر ابدأ الآن
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // لاحقاً: روح لصفحة الكتب
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('ابدأ الآن', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white54),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('ادخل الآن', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============ شاشة مؤقتة لباقي التبويبات ============
class PlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;

  const PlaceholderScreen({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            Text('$title - قريباً', style: const TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
