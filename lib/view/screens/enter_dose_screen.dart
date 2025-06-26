import 'package:flutter/material.dart';
import 'package:medical_app/core/theme/app_colors.dart';
import 'package:medical_app/models/medication_entry.dart';
import 'package:medical_app/view/screens/today_screen.dart';

class EnterDoseScreen extends StatefulWidget {
  final String medicationName;
  final String form;
  final String selectedFrequency;
  final String scheduledTime;
  final List<MedicationEntry> existingEntries;

  const EnterDoseScreen({
    super.key,
    required this.medicationName,
    required this.form,
    required this.selectedFrequency,
    required this.scheduledTime,
    required this.existingEntries,
  });

  @override
  State<EnterDoseScreen> createState() => _EnterDoseScreenState();
}

class _EnterDoseScreenState extends State<EnterDoseScreen> {
  final TextEditingController _doseController = TextEditingController();

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

  String selectedForm = 'Tablet';

  void _handleDone() {
    final dose = _doseController.text.trim();
    if (dose.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the dose quantity')),
      );
      return;
    }

    final entry = MedicationEntry(
      name: widget.medicationName,
      form: selectedForm,
      frequency: widget.selectedFrequency,
      time: widget.scheduledTime,
      dose: dose,
    );

    final updatedEntries = [...widget.existingEntries, entry];

    // Replace the entire stack with TodayScreen and pass updated entries
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => TodayScreen(entries: updatedEntries),
      ),
          (Route<dynamic> route) => false,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Enter Dose',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Dose', style: TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade700),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        controller: _doseController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Enter quantity',
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(width: 1, height: 48, color: Colors.grey.shade700),
                  PopupMenuButton<String>(
                    color: Colors.grey.shade800,
                    initialValue: selectedForm,
                    onSelected: (value) {
                      setState(() {
                        selectedForm = value;
                      });
                    },
                    itemBuilder: (context) {
                      return forms.map((form) {
                        return PopupMenuItem<String>(
                          value: form['label'],
                          child: Row(
                            children: [
                              Icon(form['icon'], color: Colors.white),
                              const SizedBox(width: 8),
                              Text(form['label'], style: const TextStyle(color: Colors.white)),
                            ],
                          ),
                        );
                      }).toList();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Icon(
                            forms.firstWhere((f) => f['label'] == selectedForm)['icon'],
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(selectedForm, style: const TextStyle(color: Colors.white)),
                          const Icon(Icons.arrow_drop_down, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleDone,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
