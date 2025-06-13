import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final box = GetStorage();

  String day = '';
  String hour = '';
  String service = '';
  String barbershop = '';
  List<dynamic> bookingHistory = [];

  @override
  void initState() {
    super.initState();
    day =
        box.read('selectedDate') != null
            ? DateFormat(
              'yyyy-MM-dd',
            ).format(DateTime.parse(box.read('selectedDate')).toLocal())
            : 'Not selected';
    hour = box.read('selectedHour') ?? 'Not selected';
    service = box.read('selectedService') ?? 'Not selected';
    barbershop = box.read('selectedBarbershop') ?? 'Not selected';

    _saveBookingHistory();
    _loadBookingHistory();
  }

  void _saveBookingHistory() {
    final booking = {
      'day': day,
      'hour': hour,
      'service': service,
      'barbershop': barbershop,
      'timestamp': DateFormat('yyyy-MM-dd – kk:mm:ss').format(DateTime.now()),
    };

    List<dynamic> bookings = box.read('bookingHistory') ?? [];
    bookings.add(booking);
    box.write('bookingHistory', bookings);
  }

  void _loadBookingHistory() {
    setState(() {
      bookingHistory = box.read('bookingHistory') ?? [];
    });
  }

  void _clearBookingHistory() {
    box.remove('bookingHistory');
    setState(() {
      bookingHistory = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Bagian Atas - Info Booking Terakhir
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
              decoration: BoxDecoration(
                color: isDark ? Colors.black : Colors.grey.shade200,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Appointment',
                          style: TextStyle(
                            color: Color(0xFFFFB800),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Bookingan kamu sudah masuk\nTerima kasih, Stay Cool Brother!',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Booking Card (Terakhir)
            Visibility(
              visible: false, // ubah ke true lagi kalau mau tampilkan
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2B6B7D),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/hair.png',
                            width: 40,
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            bookingText('Day: $day'),
                            bookingText('Hour: $hour'),
                            bookingText('Service: $service'),
                            bookingText('Barbershop: $barbershop'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Title + Tombol Hapus Riwayat
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Riwayat Booking",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  if (bookingHistory.isNotEmpty)
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder:
                              (_) => AlertDialog(
                                title: const Text("Hapus Semua Riwayat?"),
                                content: const Text(
                                  "Apakah kamu yakin ingin menghapus semua riwayat booking?",
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text("Batal"),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    child: const Text("Hapus"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _clearBookingHistory();
                                    },
                                  ),
                                ],
                              ),
                        );
                      },
                      child: const Text("Hapus Riwayat"),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Riwayat Booking List
            if (bookingHistory.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text("Belum ada riwayat booking."),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bookingHistory.length,
                itemBuilder: (context, index) {
                  final b = bookingHistory[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: ListTile(
                      leading: const Icon(Icons.history, color: Colors.amber),
                      title: Text('${b['day']} - ${b['hour']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Service: ${b['service']}'),
                          Text('Barbershop: ${b['barbershop']}'),
                          Text('Booked At: ${b['timestamp']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget bookingText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
