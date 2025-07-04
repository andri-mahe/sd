import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'location_screen.dart';
import 'appointment_controller.dart';

class HomeTab extends StatefulWidget {
  final void Function(int)? onTabChange; // Tambah ini

  const HomeTab({Key? key, this.onTabChange}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final box = GetStorage();
  List<int> _selectedServices = [];
  final appointmentController = Get.find<AppointmentController>();

  final List<Map<String, String>> services = [
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
        appointmentController.selectedService.value = services[index]['label']!;
      }
    });
  }

  void _onBarbershopSelected(String name) {
    appointmentController.selectedBarbershop.value = name;
  }

  Widget buildBarbershopCard(String name, String address, String rating) {
    return GestureDetector(
      onTap: () => _onBarbershopSelected(name),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: const BorderRadius.only(
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      address,
                      style: const TextStyle(color: Colors.amber, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onBookNowPressed() {
    final selected =
        _selectedServices.map((i) => services[i]['label']).toList();
    box.write('selectedServices', selected);

    // Panggil pindah tab
    widget.onTabChange?.call(1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // HEADER
          Container(
            color:
                theme.appBarTheme.backgroundColor ?? theme.colorScheme.surface,
            padding: const EdgeInsets.all(20),
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
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Let your hair do",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "the talking",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // SERVICE SELECTION
          Row(
            children: [
              Text("SELECT ", style: theme.textTheme.titleMedium),
              Text(
                "SERVICE",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Container(height: 3, width: 100, color: Colors.amber),
          const SizedBox(height: 20),

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
                            ? theme.colorScheme.onSurface
                            : theme.cardColor,
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
                          color:
                              isSelected
                                  ? theme.colorScheme.surface
                                  : Colors.amber,
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

          // BARBERSHOPS
          Row(
            children: [
              Text("Best Top 2 ", style: theme.textTheme.titleMedium),
              Text(
                "Barbershop",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Container(height: 3, width: 150, color: Colors.amber),
          const SizedBox(height: 20),
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

          // BOOK NOW BUTTON
          ElevatedButton(
            onPressed: _onBookNowPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Book Now',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
