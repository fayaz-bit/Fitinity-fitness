import 'package:flutter/material.dart';

class ProfileDetailsCard extends StatelessWidget {
  final dynamic user;
  final VoidCallback onEdit;
  final VoidCallback onLogout;
  final VoidCallback onPrivacy;

  const ProfileDetailsCard({
    super.key,
    required this.user,
    required this.onEdit,
    required this.onLogout,
    required this.onPrivacy,
  });

  String _safeString(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Not added";
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    const darkCard = Color(0xFF121418);
    const purple = Color(0xFF8416BC);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
            color: darkCard,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            children: [
              _infoRow(
                "Age",
                (user.age == null || user.age == 0)
                    ? "Not added"
                    : "${user.age} Years",
              ),
              _divider(),
              _infoRow("Gender", _safeString(user.gender)),
              _divider(),
              _infoRow("Phone", _safeString(user.phone)),
              _divider(),
              _infoRow(
                "Height",
                (user.height == null || user.height == 0)
                    ? "Not added"
                    : "${user.height} cm",
              ),
              _divider(),
              _infoRow(
                "Weight",
                (user.weight == null || user.weight == 0)
                    ? "Not added"
                    : "${user.weight} kg",
              ),

              const Spacer(),
              _divider(),
              const SizedBox(height: 20),

              // ACTION BUTTONS ROW (3 ITEMS NOW)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _actionButton(Icons.edit, "EDIT PROFILE", purple, onEdit),
                  _actionButton(Icons.privacy_tip_outlined, "SETTINGS",
                      Colors.white70, onPrivacy),
                  _actionButton(
                      Icons.logout, "LOG OUT", Colors.purple, onLogout),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white60, fontSize: 15)),
          Text(value,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 1,
      color: Colors.white12,
      margin: const EdgeInsets.symmetric(vertical: 5),
    );
  }

  Widget _actionButton(
      IconData icon, String text, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 6),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
