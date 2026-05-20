import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_mobile/controllers/auth_controller.dart';
import 'package:quiz_mobile/screen/login.dart';
import 'package:quiz_mobile/services/session_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = '...';
  String? _imagePath;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final username = await SessionService.getUsername() ?? 'Unknown';
    final imgPath = await SessionService.getProfileImagePath();
    if (!mounted) return;
    setState(() { _username = username; _imagePath = imgPath; });
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? file = await _picker.pickImage(source: source, maxWidth: 512, maxHeight: 512, imageQuality: 80);
      if (file == null) return;
      await SessionService.saveProfileImagePath(file.path);
      if (!mounted) return;
      setState(() => _imagePath = file.path);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not access camera/gallery')),
      );
    }
  }

  void _showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => SafeArea(child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('Choose Profile Photo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ListTile(leading: const Icon(Icons.camera_alt), title: const Text('Camera'),
            onTap: () { Navigator.pop(context); _pickImage(ImageSource.camera); }),
          ListTile(leading: const Icon(Icons.photo_library), title: const Text('Gallery'),
            onTap: () { Navigator.pop(context); _pickImage(ImageSource.gallery); }),
        ]),
      )),
    );
  }

  Future<void> _logout() async {
    final AuthController auth = Get.find<AuthController>();
    await auth.logout();
    Get.offAll(() => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(children: [
          const SizedBox(height: 20),

          // Avatar
          GestureDetector(
            onTap: _showImagePickerSheet,
            child: Stack(children: [
              CircleAvatar(
                radius: 56,
                backgroundColor: cs.primaryContainer,
                backgroundImage: _imagePath != null ? FileImage(File(_imagePath!)) : null,
                child: _imagePath == null ? Icon(Icons.person, size: 56, color: cs.onPrimaryContainer) : null,
              ),
              Positioned(bottom: 0, right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle,
                    border: Border.all(color: cs.surface, width: 3)),
                  child: Icon(Icons.camera_alt, size: 16, color: cs.onPrimary),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 30),

          // Info cards
          _infoCard(cs, Icons.person_outline, 'Name', 'Elyuzar'),
          _infoCard(cs, Icons.badge_outlined, 'NIM', '123230216'),
          _infoCard(cs, Icons.alternate_email, 'Username', _username),

          const SizedBox(height: 40),

          // Logout
          SizedBox(width: double.infinity, height: 52,
            child: OutlinedButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              label: const Text('Logout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.redAccent)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.redAccent),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _infoCard(ColorScheme cs, IconData icon, String label, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.3)),
      ),
      child: Row(children: [
        Icon(icon, color: cs.primary, size: 24),
        const SizedBox(width: 16),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: TextStyle(fontSize: 12, color: cs.onSurface.withOpacity(0.5))),
          const SizedBox(height: 2),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: cs.onSurface)),
        ]),
      ]),
    );
  }
}