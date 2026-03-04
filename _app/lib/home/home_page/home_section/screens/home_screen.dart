import 'package:_app/home/home_page/home_section/controllers/home_controller.dart';
import 'package:_app/home/home_page/home_section/widget/home_section_list.dart';
import 'package:flutter/material.dart';
import '../../search_option/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = HomeController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // 🔥 Bottom Nav (dark like image)
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        currentIndex: controller.selectedIndex,
        onTap: (i) => controller.onNavTap(context, i, () => setState(() {})),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Timer"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          children: [
            /// 🔥 HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B2CF5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                          const Icon(Icons.fitness_center, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "FITNITYY",
                      style: TextStyle(
                        color: Color(0xFF8B2CF5),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SearchPage()),
                    );
                  },
                  child: const Icon(Icons.search, color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 25),

            /// 🔥 Your Sections (we will redesign widget below)
            HomeSectionList(
              sections: controller.homeSections,
              onTap: (title) => controller.openSection(context, title),
            ),
          ],
        ),
      ),
    );
  }
}
