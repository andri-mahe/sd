import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'appointment_controller.dart';

class AppointmentScreen extends StatelessWidget {
  final Function(int tabIndex)? onTabChange;
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

  AppointmentScreen({Key? key, this.onTabChange}) : super(key: key);

  List<Widget> _buildDateGrid(
    AppointmentController controller,
    ThemeData theme,
  ) {
    final daysInMonth = DateUtils.getDaysInMonth(
      controller.focusedDay.year,
      controller.focusedDay.month,
    );
    final firstDay = DateTime(
      controller.focusedDay.year,
      controller.focusedDay.month,
      1,
    );
    final weekdayOffset = firstDay.weekday % 7;
    final totalCells = daysInMonth + weekdayOffset;
    final List<Widget> dayWidgets = [];

    for (int i = 0; i < totalCells; i++) {
      if (i < weekdayOffset) {
        dayWidgets.add(const SizedBox());
      } else {
        final day = i - weekdayOffset + 1;
        final date = DateTime(
          controller.focusedDay.year,
          controller.focusedDay.month,
          day,
        );
        final isSelected =
            controller.selectedDay != null &&
            controller.selectedDay!.difference(date).inDays == 0;

        dayWidgets.add(
          GestureDetector(
            onTap: () => controller.selectDay(date),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? Colors.amber : Colors.transparent,
                border: Border.all(color: theme.dividerColor),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                '$day',
                style: TextStyle(
                  color:
                      isSelected
                          ? Colors.black
                          : theme.textTheme.bodyMedium?.color,
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
    final theme = Theme.of(context);
    final box = GetStorage();

    return GetBuilder<AppointmentController>(
      init: AppointmentController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Container(
                    decoration: BoxDecoration(
                      color: theme.cardColor,
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
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // SELECT DATE
                  Row(
                    children: [
                      Text("SELECT DATE", style: theme.textTheme.titleMedium),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(height: 2, color: Colors.amber),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
                        DateFormat.MMMM()
                            .format(controller.focusedDay)
                            .toUpperCase(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  GridView.count(
                    crossAxisCount: 7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: _buildDateGrid(controller, theme),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.amber,
                        ),
                        onPressed: () => controller.changeMonth(false),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "${DateFormat.MMMM().format(controller.focusedDay).toUpperCase()} ${controller.focusedDay.year}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.chevron_right,
                          color: Colors.amber,
                        ),
                        onPressed: () => controller.changeMonth(true),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // SELECT HOUR
                  Row(
                    children: [
                      Text("SELECT HOUR", style: theme.textTheme.titleMedium),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(height: 2, color: Colors.amber),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: hours.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 2.5,
                        ),
                    itemBuilder: (context, index) {
                      final hour = hours[index];
                      final isSelected = controller.selectedHour == hour;

                      return GestureDetector(
                        onTap: () => controller.selectHour(hour),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color:
                                isSelected ? Colors.amber : Colors.transparent,
                            border: Border.all(color: theme.dividerColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            hour,
                            style: TextStyle(
                              color:
                                  isSelected
                                      ? Colors.black
                                      : theme.textTheme.bodyMedium?.color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),

                  // BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (controller.selectedDay != null &&
                                controller.selectedHour != null) {
                              box.write(
                                'selectedDate',
                                controller.selectedDay!.toIso8601String(),
                              );
                              box.write(
                                'selectedHour',
                                controller.selectedHour,
                              );
                              box.write(
                                'selectedService',
                                controller.selectedService.value,
                              );
                              box.write(
                                'selectedBarbershop',
                                controller.selectedBarbershop.value,
                              );

                              onTabChange?.call(3);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            "BOOK NOW",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            controller.reset();
                            box.remove('selectedDate');
                            box.remove('selectedHour');
                            box.remove('selectedService');
                            box.remove('selectedBarbershop');
                            onTabChange?.call(0);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            "CANCEL",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
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
      },
    );
  }
}
