import 'package:coba/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedHour;

  final List<String> hours = [
    '8:00 A.M.',
    '9:00 A.M.',
    '10:00 A.M.',
    '11:00 A.M.',
    '12:00 P.M.',
    '01:00 P.M.',
    '02:00 P.M.',
    '03:00 P.M.',
    '05:00 P.M.',
    '06:00 P.M.',
    '07:00 P.M.',
    '08:00 P.M.',
  ];

  List<Widget> _buildDateGrid() {
    final daysInMonth = DateUtils.getDaysInMonth(
      _focusedDay.year,
      _focusedDay.month,
    );
    final firstDay = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final weekdayOffset = firstDay.weekday % 7;

    final totalCells = daysInMonth + weekdayOffset;
    final List<Widget> dayWidgets = [];

    for (int i = 0; i < totalCells; i++) {
      if (i < weekdayOffset) {
        dayWidgets.add(const SizedBox()); // kosong sebelum tanggal 1
      } else {
        final day = i - weekdayOffset + 1;
        final date = DateTime(_focusedDay.year, _focusedDay.month, day);
        final isSelected =
            _selectedDay != null &&
            _selectedDay!.year == date.year &&
            _selectedDay!.month == date.month &&
            _selectedDay!.day == date.day;

        dayWidgets.add(
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedDay = date;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? Colors.amber : Colors.transparent,
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                '$day',
                style: TextStyle(
                  color:
                      isSelected
                          ? Colors.black
                          : Theme.of(context).textTheme.bodyMedium?.color,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }
    }

    return dayWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Image.asset('assets/logo.png', width: 70),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Appointment",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Silahkan pilih tanggal dan jam untuk membuat janji temu atau booking",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Select Date Title
              Row(
                children: [
                  Text(
                    "SELECT DATE",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Container(height: 2, color: Colors.amber)),
                ],
              ),
              const SizedBox(height: 10),

              // Month Label
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    DateFormat.MMMM().format(_focusedDay).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Date Grid
              GridView.count(
                crossAxisCount: 7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: _buildDateGrid(),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _focusedDay = DateTime(
                        _focusedDay.year,
                        _focusedDay.month + 1,
                      );
                      _selectedDay = null;
                    });
                  },
                  child: Text(
                    "See More >",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Select Hour Title
              Row(
                children: [
                  Text(
                    "SELECT HOUR",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Container(height: 2, color: Colors.amber)),
                ],
              ),
              const SizedBox(height: 10),

              // Hour Grid
              GridView.builder(
                shrinkWrap: true,
                itemCount: hours.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2.5,
                ),
                itemBuilder: (context, index) {
                  final hour = hours[index];
                  final isSelected = _selectedHour == hour;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedHour = hour;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.amber : Colors.transparent,
                        border: Border.all(
                          color: Theme.of(context).dividerColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        hour,
                        style: TextStyle(
                          color:
                              isSelected
                                  ? Colors.black
                                  : Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedDay != null && _selectedHour != null) {
                          Get.to(() => ());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "BOOK NOW",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.to(LocationScreen()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "CANCEL",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
