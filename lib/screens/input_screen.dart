import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/nic_decoder_controller.dart';

class InputScreen extends GetView<NICDecoderController> {
  const InputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sri Lankan NIC Decoder',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/images.png',
                      ),
                      opacity: 0.15,
                      fit: BoxFit.contain),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 52),
                    const Text(
                      'Enter NIC Number',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: controller.nicController,
                      decoration: InputDecoration(
                        hintText: 'NIC Number',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => controller.nicController.clear(),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'e.g. 853400937V or 198534009377',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 352),
                    ElevatedButton.icon(
                      onPressed: () {
                        String nic = controller.nicController.text.trim();
                        if (nic.isNotEmpty) {
                          controller.decodeNIC(nic);
                        } else {
                          Get.snackbar(
                            'Error',
                            'Please enter a valid NIC',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red.shade100,
                            colorText: Colors.red.shade900,
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.search,
                        size: 24,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Decode NIC',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 34),
                    Text(
                      'Supports both old (9 digits + letter) and new (12 digits) NIC formats',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
