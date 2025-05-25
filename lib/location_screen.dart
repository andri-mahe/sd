import 'menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final box = GetStorage();
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> barbershops = [
    {
      'name': "Oesman's Barbershop",
      'address': "Jl. Dr. Wahidin No.3B, Penumping",
      'rating': '4.7',
    },
    {
      'name': "Macho Barbershop",
      'address': "Jl. Solo - Tawangmangu km. 11",
      'rating': '4.5',
    },
    {
      'name': "Star Barbershop",
      'address': "Taman Jaya Wijaya, Surakarta",
      'rating': '4.5',
    },
    {
      'name': "Doel’s Barbershop",
      'address': "Jl. Doktor Moewardi, Purwosari",
      'rating': '4.4',
    },
    {
      'name': "Arfa Barbershop",
      'address': "Jl. Honggowongso No.81, Jayengan",
      'rating': '4.3',
    },
    {
      'name': "Luji Barbershop",
      'address': "Jl. Moh. Husni Thamrin, Kerten",
      'rating': '4.2',
    },
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final username = box.read('username') ?? '';
    final password = box.read('password') ?? '';
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // HEADER
            Container(
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/logo.png', width: 80),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat datang di barbershop kami\nsilakan pilih layanan apa yang kamu butuhkan.",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.textTheme.bodySmall?.color
                                ?.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Let your hair do",
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "the talking",
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // SEARCH
            Row(
              children: [
                Text("SEARCH BY ", style: theme.textTheme.titleMedium),
                Text(
                  "LOCATION",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Container(height: 3, width: 160, color: Colors.amber),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: theme.textTheme.bodyMedium,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: theme.cardColor.withOpacity(0.3),
                      prefixIcon: Icon(
                        Icons.search,
                        color: theme.iconTheme.color,
                      ),
                      hintText: 'Insert your location here',
                      hintStyle: theme.textTheme.bodySmall?.copyWith(
                        color: theme.hintColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Search"),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // LIST BARBERSHOPS
            ...List.generate(barbershops.length, (index) {
              final shop = barbershops[index];
              final isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    box.write('selectedBarbershop', shop);
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? theme.colorScheme.primary
                            : theme.cardColor.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12),
                    border:
                        isSelected
                            ? Border.all(color: Colors.amber, width: 2)
                            : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: theme.colorScheme.onPrimary,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              shop['rating']!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                shop['name']!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                shop['address']!,
                                style: const TextStyle(color: Colors.amber),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
