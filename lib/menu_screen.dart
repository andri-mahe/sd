import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'home_screen.dart';

class MenuScreen extends StatefulWidget {
  final String username;
  final String password;

  const MenuScreen({required this.username, required this.password, Key? key})
    : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<int> _selectedServices = [];
  int _selectedIndex = 0;

  List<Map<String, String>> services = [
    {'image': 'assets/hair.png', 'label': 'HAIR CUT'},
    {'image': 'assets/trim.png', 'label': 'TRIMMING'},
    {'image': 'assets/shav.png', 'label': 'SHAVING'},
    {'image': 'assets/facial.png', 'label': 'FACIAL CARE'},
    {'image': 'assets/hairt.png', 'label': 'HAIR CARE'},
    {'image': 'assets/col.png', 'label': 'COLORING'},
  ];

  void _onServiceTap(int index) {
    setState(() {
      if (_selectedServices.contains(index)) {
        _selectedServices.remove(index);
      } else {
        _selectedServices.add(index);
      }
    });
  }

  void _onNextPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationScreen()),
    );
  }

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0: // HOME
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 1: // LOKASI
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LocationScreen()),
        );
        break;
    }
  }

  Widget buildBarbershopCard(String name, String address, String rating) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF29697C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFFB300),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                const Icon(Icons.star, color: Colors.white, size: 24),
                const SizedBox(height: 4),
                Text(
                  rating,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: const TextStyle(
                      color: Color(0xFFFFB300),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1B1F),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Header
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Image.asset('assets/logo.png', width: 100)),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        children: [
                          const TextSpan(
                            text: "Hello ",
                            style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: widget.username),
                          const TextSpan(
                            text: "\nPASS : ",
                            style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: widget.password),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Selamat datang di barbershop kami\nsilakan pilih layanan apa yang kamu butuhkan.",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Let your hair do",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "the talking",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Select Service
              Row(
                children: const [
                  Text(
                    "SELECT ",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "SERVICE",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Container(height: 3, width: 100, color: Colors.amber),
              const SizedBox(height: 20),

              // Services Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: services.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  bool isSelected = _selectedServices.contains(index);
                  return GestureDetector(
                    onTap: () => _onServiceTap(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? Colors.white
                                : Colors.blueGrey.shade700,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(services[index]['image']!, height: 50),
                          const SizedBox(height: 10),
                          Text(
                            services[index]['label']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.amber,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),

              // Best Barbershop Section
              Row(
                children: const [
                  Text(
                    "Best Top 2 ",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "Barbershop",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Container(height: 3, width: 150, color: Colors.amber),
              const SizedBox(height: 20),

              // Best Barbershop Cards (NEW DESIGN)
              buildBarbershopCard(
                "Oesman's Barbershop",
                "Jl. Dr. Wahidin No.3B, Penumping",
                "4.7",
              ),
              buildBarbershopCard(
                "Macho Barbershop",
                "Jl. Solo - Tawangmangu km.11",
                "4.5",
              ),
              const SizedBox(height: 30),

              // NEXT Button
              ElevatedButton(
                onPressed: _onNextPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "NEXT",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: const Color.fromARGB(179, 7, 175, 231),
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
        ],
      ),
    );
  }
}
