import 'package:flutter/material.dart';
import 'package:medical_app/models/medication_entry.dart';
import '../../core/theme/app_colors.dart';
import 'set_frequency_screen.dart';

class SelectFormScreen extends StatelessWidget {
  final String medicationName;

  const SelectFormScreen({super.key, required this.medicationName, required List<MedicationEntry> existingEntries});

  final List<Map<String, dynamic>> forms = const [
    {'label': 'Tablet', 'icon': Icons.block},
    {'label': 'Capsule', 'icon': Icons.medication},
    {'label': 'Syrup', 'icon': Icons.opacity},
    {'label': 'Injection', 'icon': Icons.local_hospital},
    {'label': 'Cream', 'icon': Icons.brush},
    {'label': 'Drops', 'icon': Icons.remove_red_eye},
    {'label': 'Inhaler', 'icon': Icons.air},
    {'label': 'Powder', 'icon': Icons.cloud},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select Form',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 0),
            Text(
              medicationName,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: forms.length,
                itemBuilder: (context, index) {
                  final item = forms[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SetFrequencyScreen(
                            medicationName: medicationName,
                            form: item['label'] as String,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade800),
                      ),
                      child: Row(
                        children: [
                          Icon(item['icon'] as IconData, color: AppColors.primary),
                          const SizedBox(width: 16),
                          Text(
                            item['label'] as String,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
