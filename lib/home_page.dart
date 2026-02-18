import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: const Color(0xffFCE325),
        unselectedItemColor: Colors.white54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
body: Container(
  decoration: const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFFFBFDB6),
        Colors.white,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.0, 0.6],
    ),
  ),
  child: SafeArea(
    child: ListView(

          padding: const EdgeInsets.all(16),
          children: [
            /// 📍 Location & Greeting
            Row(
              children: const [
                Icon(Icons.location_on),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello Full name",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Location location location",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            const AutoSliderTireCards(),


            const SizedBox(height: 25),

            /// 🛠 Our Services
            const Text(
              "Our services",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
             ServiceItem(imagePath: "assets/img/car.png", title: "Car"),
             ServiceItem(imagePath: "assets/img/truck.png", title: "Truck & Bus"),
             ServiceItem(imagePath: "assets/img/motorcycle.png", title: "Motorcycle"),
             ServiceItem(imagePath: "assets/img/battery.png", title: "Battery & Tire"),

              ],
            ),

            const SizedBox(height: 25),

            ///  Discount Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 196),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
             Image.asset(
  'assets/img/offer.png',
  width: 55,  
  height: 55,
),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Get 10% Off Your First Service",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Enjoy a special discount on your first dépannage request.",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// ⭐ Popular
            const Text(
              "Popular",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            SizedBox(
  height: 250,
  child: ListView(
    scrollDirection: Axis.horizontal,
    children: [
      buildImageCard("assets/img/image1.png"),
      const SizedBox(width: 12),
      buildImageCard("assets/img/image2.png"),
    ],
  ),
),

          ],
        ),
      ),
    ),);
  }
}

/// 🔹 Service image Widget
class ServiceItem extends StatelessWidget {
  final String imagePath;
  final String title;

  const ServiceItem({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: const Color(0xffF4F4F4
          ),
          child: Image.asset(
            imagePath,
            width: 48,
            height: 48,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

Widget buildImageCard(String imagePath) {
  return Container(
    width: 220,
    height: 247,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      image: DecorationImage(
        image: AssetImage(imagePath),
        fit: BoxFit.cover,
      ),
    ),
  );
}



  
class AutoSliderTireCards extends StatefulWidget {
  const AutoSliderTireCards({super.key});

  @override
  State<AutoSliderTireCards> createState() => _AutoSliderTireCardsState();
}

class _AutoSliderTireCardsState extends State<AutoSliderTireCards> {
  final PageController _pageController = PageController(viewportFraction: 1);
  int _currentPage = 0;
  Timer? _timer;

 
  final List<Map<String, String>> _cardsData = [
    {
      "image": "assets/img/tire.jpg",
      "title": "Tire Change Service",
      "subtitle": "Wherever You are \nFast, Safe, and Reliable",
      "button": "Get Tire Help Now",
    },
    {
      "image": "assets/img/car_towing.jpg",
      "title": "Car Towing Service",
      "subtitle": "Fast help anywhere \nReliable and Safe",
      "button": "Get Battery Help",
    },
    
    
  ];

  @override
  void initState() {
    super.initState();

    // Auto slide every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      final nextPage = (_currentPage + 1) % _cardsData.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      _currentPage = nextPage;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemCount: _cardsData.length,
              itemBuilder: (context, index) {
                final card = _cardsData[index];
                return buildCard(
                  image: card["image"]!,
                  title: card["title"]!,
                  subtitle: card["subtitle"]!,
                  buttonText: card["button"]!,
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          // مؤشر الكروت
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_cardsData.length, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 12 : 8,
                height: _currentPage == index ? 12 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index ? Colors.yellow : Colors.white54,
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  //  card Widget 
  Widget buildCard({
    required String image,
    required String title,
    required String subtitle,
    required String buttonText,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.black54, Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white70),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFCE325),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {},
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
