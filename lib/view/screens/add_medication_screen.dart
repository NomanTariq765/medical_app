import 'package:flutter/material.dart';
import 'package:medical_app/core/theme/app_colors.dart';
import 'package:medical_app/models/medication_entry.dart';
import 'package:medical_app/view/screens/select_form_screen.dart';

class AddMedicationScreen extends StatelessWidget {
  final List<MedicationEntry> existingEntries;

  const AddMedicationScreen({super.key, required this.existingEntries});

  @override
  Widget build(BuildContext context) {
    final TextEditingController medController = TextEditingController();

    // Dummy placeholders (you would replace these with actual selections)
    const String selectedForm = 'Tablet';
    const String selectedFrequency = 'Once a day';
    final String scheduledTime = TimeOfDay.now().format(context); // Example time

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Name Medication",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: medController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Type here",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF2A2A2A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                final name = medController.text.trim();
                if (name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter medication name')),
                  );
                  return;
                }

                final updatedEntries = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SelectFormScreen(
                      medicationName: name,
                      existingEntries: existingEntries,
                    ),
                  ),
                );

                if (updatedEntries != null) {
                  Navigator.pop(context, updatedEntries);
                }
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Next", style: TextStyle(color: Colors.white,fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
