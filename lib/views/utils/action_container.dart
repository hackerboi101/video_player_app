import 'package:flutter/material.dart';

class ActionContainer extends StatelessWidget {
  const ActionContainer({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(11.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.grey.shade700),
          const SizedBox(height: 4.0),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 13.0,
            ),
          ),
        ],
      ),
    );
  }
}
