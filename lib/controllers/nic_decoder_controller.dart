import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NICDecoderController extends GetxController {
  final Rx<String> nicNumber = ''.obs; // Added for displaying input NIC
  final Rx<String> dob = ''.obs;
  final Rx<String> gender = ''.obs;
  final Rx<String> weekday = ''.obs;
  final Rx<int> age = 0.obs;
  final Rx<String> format = ''.obs;
  final nicController = TextEditingController();

  @override
  void onClose() {
    nicController.dispose();
    super.onClose();
  }

  void decodeNIC(String nic) {
    nicNumber.value = nic; // Store the input NIC number

    bool isOldFormat =
        nic.length == 10 && RegExp(r'^[0-9]{9}[VXvx]$').hasMatch(nic);
    bool isNewFormat = nic.length == 12 && RegExp(r'^[0-9]{12}$').hasMatch(nic);

    if (!isOldFormat && !isNewFormat) {
      Get.snackbar(
        'Error',
        'Invalid NIC format',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
      return;
    }

    format.value = isOldFormat ? 'Old Format' : 'New Format';

    int birthYear = isOldFormat
        ? int.parse('19${nic.substring(0, 2)}')
        : int.parse(nic.substring(0, 4));
    int dayOfYear =
        int.parse(nic.substring(isOldFormat ? 2 : 4, isOldFormat ? 5 : 7));

    gender.value = dayOfYear > 500 ? 'Female' : 'Male';
    dayOfYear = dayOfYear > 500 ? dayOfYear - 500 : dayOfYear;

    DateTime dateOfBirth =
        DateTime(birthYear).add(Duration(days: dayOfYear - 1));
    dob.value = DateFormat('dd/MM/yyyy').format(dateOfBirth);
    weekday.value = DateFormat('EEEE').format(dateOfBirth);
    age.value = DateTime.now().year - birthYear;

    Get.toNamed('/result');
  }

  void clearData() {
    nicController.clear();
    nicNumber.value = ''; // Clear the stored NIC number
    dob.value = '';
    gender.value = '';
    weekday.value = '';
    age.value = 0 ;
    format.value = '';
  }
}
