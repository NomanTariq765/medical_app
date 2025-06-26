import 'package:flutter/material.dart';
import 'package:medical_app/core/theme/app_colors.dart';
import 'package:medical_app/models/medication_entry.dart';
import 'package:medical_app/view/screens/profile_screen.dart';
import 'package:table_calendar/table_calendar.dart';

import 'add_medication_screen.dart';
import 'enter_dose_screen.dart';

class TodayScreen extends StatefulWidget {
  final List<MedicationEntry> entries;

  const TodayScreen({super.key, required this.entries});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  late List<MedicationEntry> entries;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  @override
  void initState() {
    super.initState();
    entries = [...widget.entries]; // Make a copy
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text("Today", style: TextStyle(fontSize: 22)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProfileScreen(onProfileUpdated: (_, __) {})),
                );
              },
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),

          )
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: focusedDay,
            calendarFormat: CalendarFormat.week,
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerVisible: false,
            daysOfWeekVisible: true,
            selectedDayPredicate: (day) => isSameDay(selectedDay, day),
            onDaySelected: (selected, focused) {
              setState(() {
                selectedDay = selected;
                focusedDay = focused;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
              defaultTextStyle: const TextStyle(color: AppColors.white),
              weekendTextStyle: const TextStyle(color: AppColors.grey),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekendStyle: TextStyle(color: AppColors.grey),
              weekdayStyle: TextStyle(color: AppColors.white),
            ),
          ),
          const SizedBox(height: 24),
          entries.isEmpty
              ? const Text("No meds for today",
              style: TextStyle(color: AppColors.white, fontSize: 16))
              : Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildMedicationCard(entry),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add, color: Colors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
                onPressed: () async {
    final result = await Navigator.push(
    context,
    MaterialPageRoute(
    builder: (_) => AddMedicationScreen(existingEntries: entries),
    ),
    );

    if (result != null && result is List<MedicationEntry>) {
    setState(() {
    entries = result;
    });
    }
    },




              label: const Text("Add Medication",
                  style: TextStyle(color: AppColors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationCard(MedicationEntry entry) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade800),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                entry.time,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(width: 4),
              Text(
                entry.time.contains('AM') ? '' : 'PM',
                style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              )
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade800, thickness: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getIconForForm(entry.form),
                  color: Colors.blueAccent,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${entry.dose} ${entry.form} | ${entry.frequency}",
                    style:
                    const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getIconForForm(String form) {
    switch (form.toLowerCase()) {
      case 'tablet':
        return Icons.block;
      case 'capsule':
        return Icons.medication;
      case 'syrup':
        return Icons.opacity;
      case 'injection':
        return Icons.local_hospital;
      case 'cream':
        return Icons.brush;
      case 'drops':
        return Icons.remove_red_eye;
      case 'inhaler':
        return Icons.air;
      case 'powder':
        return Icons.cloud;
      default:
        return Icons.medical_services;
    }
  }
}
