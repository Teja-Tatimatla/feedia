import 'package:flutter/material.dart';

class HomeOptionCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const HomeOptionCard({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.orangeAccent),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              color: Color.fromRGBO(231, 214, 194, 1),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
