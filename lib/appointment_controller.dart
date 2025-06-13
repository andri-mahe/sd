import 'package:get/get.dart';

class AppointmentController extends GetxController {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  String? selectedHour;

  // Tambahan booking data
  var selectedService = ''.obs;
  var selectedBarbershop = ''.obs;
  var selectedDate = ''.obs;
  var selectedHourText = ''.obs;

  void selectDay(DateTime day) {
    selectedDay = day;
    update(); // Trigger GetBuilder
  }

  void selectHour(String hour) {
    selectedHour = hour;
    selectedHourText.value = hour;
    update(); // Trigger GetBuilder
  }

  void changeMonth(bool isNext) {
    focusedDay =
        isNext
            ? DateTime(focusedDay.year, focusedDay.month + 1)
            : DateTime(focusedDay.year, focusedDay.month - 1);
    update();
  }

  void reset() {
    selectedDay = null;
    selectedHour = null;
    selectedService.value = '';
    selectedBarbershop.value = '';
    selectedDate.value = '';
    selectedHourText.value = '';
    update();
  }
}
