import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'enter_dose_screen.dart';

class ScheduleDoseScreen extends StatefulWidget {
  final String medicationName;
  final String form;
  final String selectedFrequency;

  const ScheduleDoseScreen({
    super.key,
    required this.medicationName,
    required this.form,
    required this.selectedFrequency,
  });

  @override
  State<ScheduleDoseScreen> createState() => _ScheduleDoseScreenState();
}

class _ScheduleDoseScreenState extends State<ScheduleDoseScreen> {
  int selectedHour = 8;
  int selectedMinute = 30;
  String selectedPeriod = 'AM';

  Future<void> _selectTime(BuildContext context) async {
    final initialTime = TimeOfDay(
      hour: selectedHour % 12 + (selectedPeriod == 'PM' ? 12 : 0),
      minute: selectedMinute,
    );

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            timePickerTheme: const TimePickerThemeData(
              backgroundColor: Colors.black,
              dialHandColor: Colors.white,
              hourMinuteTextColor: Colors.white,
              dialTextColor: Colors.white70,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedHour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
        selectedMinute = picked.minute;
        selectedPeriod = picked.period == DayPeriod.am ? 'AM' : 'PM';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheduledTime = "${selectedHour.toString().padLeft(2, '0')}:"
        "${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod";

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
          'Schedule Dose',
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
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade700),
              ),
              child: Text(
                widget.selectedFrequency,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Expanded(
              child: Center(
                child: InkWell(
                  onTap: () => _selectTime(context),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade700),
                    ),
                    child: Text(
                      scheduledTime,
                      style:
                      const TextStyle(color: Colors.white, fontSize: 32),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // onPressed: () {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text(
                //         "Scheduled ${widget.medicationName} (${widget.form}) "
                //             "at $scheduledTime - ${widget.selectedFrequency}",
                //       ),
                //     ),
                //   );
                // },
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EnterDoseScreen(
                        medicationName: widget.medicationName,
                        form: widget.form,
                        selectedFrequency: widget.selectedFrequency,
                        scheduledTime: scheduledTime, existingEntries: [],
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}