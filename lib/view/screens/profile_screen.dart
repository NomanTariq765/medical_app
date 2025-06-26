// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:medical_app/core/theme/app_colors.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class ProfileScreen extends StatefulWidget {
//   final Function(File?, String) onProfileUpdated;
//
//   const ProfileScreen({super.key, required this.onProfileUpdated});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   File? _image;
//   String _name = "Noman Tariq";
//
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(source: ImageSource.gallery);
//
//     if (picked != null) {
//       setState(() {
//         _image = File(picked.path);
//       });
//       widget.onProfileUpdated(_image, _name);
//     }
//   }
//
//
//   void _showPrivacyPolicy() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Privacy Policy"),
//         content: const Text(
//             "We value your privacy.\n\n"
//                 "- Your data is stored securely.\n"
//                 "- We do not share information with third parties.\n"
//                 "- You can delete your data anytime."),
//         actions: [
//           TextButton(
//             child: const Text("Close"),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _editProfileName() {
//     final controller = TextEditingController(text: _name);
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Change Profile Name"),
//         content: TextField(
//           controller: controller,
//           decoration: const InputDecoration(hintText: "Enter your name"),
//         ),
//         actions: [
//           TextButton(
//             child: const Text("Cancel"),
//             onPressed: () => Navigator.pop(context),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
//             child: const Text("Save"),
//             onPressed: () {
//               setState(() {
//                 _name = controller.text.trim();
//               });
//               widget.onProfileUpdated(_image, _name);
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         backgroundColor: AppColors.background,
//         title: const Text("Profile", style: TextStyle(color: Colors.white)),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: _pickImage,
//               child: CircleAvatar(
//                 radius: 50,
//                 backgroundImage: _image != null ? FileImage(_image!) : null,
//                 child: _image == null
//                     ? const Icon(Icons.camera_alt, size: 40, color: Colors.white)
//                     : null,
//               ),
//             ),
//             const SizedBox(height: 24),
//             Text(_name, style: const TextStyle(color: Colors.white, fontSize: 18)),
//             const SizedBox(height: 12),
//             const Divider(color: Colors.grey),
//             ListTile(
//               leading: const Icon(Icons.privacy_tip, color: Colors.white),
//               title: const Text("Privacy Policy", style: TextStyle(color: Colors.white)),
//               onTap: _showPrivacyPolicy,
//             ),
//             ListTile(
//               leading: const Icon(Icons.edit, color: Colors.white),
//               title: const Text("Change Profile Info", style: TextStyle(color: Colors.white)),
//               subtitle: const Text("Name, Email, etc.", style: TextStyle(color: Colors.white54)),
//               onTap: _editProfileName,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_app/core/theme/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileScreen extends StatefulWidget {
  final Function(File?, String) onProfileUpdated;

  const ProfileScreen({super.key, required this.onProfileUpdated});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  String _name = "Noman Tariq";

  Future<void> _pickImage() async {
    final status = await Permission.storage.request(); // or Permission.photos on iOS
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Permission denied to access gallery")),
      );
      return;
    }

    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
      widget.onProfileUpdated(_image, _name); // Notify parent to update TodayScreen too
    }
  }

  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Privacy Policy"),
        content: const Text(
            "We value your privacy.\n\n"
                "- Your data is stored securely.\n"
                "- We do not share information with third parties.\n"
                "- You can delete your data anytime."
        ),
        actions: [
          TextButton(
            child: const Text("Close"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _editProfileName() {
    final controller = TextEditingController(text: _name);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Change Profile Name"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter your name"),
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text("Save"),
            onPressed: () {
              setState(() {
                _name = controller.text.trim();
              });
              widget.onProfileUpdated(_image, _name);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? const Icon(Icons.camera_alt, size: 40, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(height: 24),
            Text(_name, style: const TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 12),
            const Divider(color: Colors.grey),
            ListTile(
              leading: const Icon(Icons.privacy_tip, color: Colors.white),
              title: const Text("Privacy Policy", style: TextStyle(color: Colors.white)),
              onTap: _showPrivacyPolicy,
            ),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.white),
              title: const Text("Change Profile Info", style: TextStyle(color: Colors.white)),
              subtitle: const Text("Name, Email, etc.", style: TextStyle(color: Colors.white54)),
              onTap: _editProfileName,
            ),
          ],
        ),
      ),
    );
  }
}
