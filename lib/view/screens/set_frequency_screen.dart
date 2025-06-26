import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'schedule_dose_screen.dart';

class SetFrequencyScreen extends StatelessWidget {
  final String medicationName;
  final String form;

  const SetFrequencyScreen({
    super.key,
    required this.medicationName,
    required this.form,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> frequencies = [
      '1 Time, Daily',
      '2 Time, Daily',
      '3 Time, Daily',
      'More than 3 Time, Daily',
      'Specific Day of Week',
      'Every X Days',
      'Every X Weeks',
      'Every X Months',
    ];

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
          'Set Frequency',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: frequencies.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ScheduleDoseScreen(
                            medicationName: medicationName,
                            form: form,
                            selectedFrequency: frequencies[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade700),
                      ),
                      child: Text(
                        frequencies[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
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
