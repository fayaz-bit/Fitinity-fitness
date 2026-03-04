import 'package:_app/home/profile_details/edit_profile_section/controllers/edit_profile_controller.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late EditProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = EditProfileController();
    controller.loadUser(() => setState(() {}));
  }

  Widget buildField(String label, TextEditingController controller,
      {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF1E1F29),
                Color(0xFF2A2C3A),
              ],
            ),
          ),
          child: TextField(
            controller: controller,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (controller.currentUser == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Colors.deepPurple),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Edit Profile Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1.5,
            color: Colors.purple.withOpacity(0.5),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              buildField("Full Name", controller.name),
              buildField("Mobile Number", controller.phone),
              buildField("Email Address", controller.email),

              /// Gender & Age
              Row(
                children: [
                  Expanded(
                    child: buildField("Gender", controller.gender),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: buildField("Age", controller.age, isNumber: true),
                  ),
                ],
              ),

              /// Height & Weight
              Row(
                children: [
                  Expanded(
                    child: buildField("Height (CM)", controller.height,
                        isNumber: true),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: buildField("Weight (KG)", controller.weight,
                        isNumber: true),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              /// Save Button
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF7B2FF7),
                      Color(0xFF9A4DFF),
                    ],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () => controller.saveChanges(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              const Text(
                "By saving changes, you agree to our updated terms of service and privacy policy regarding personal data.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
