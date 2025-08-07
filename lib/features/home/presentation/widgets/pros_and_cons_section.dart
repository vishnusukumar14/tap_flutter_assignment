import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProsAndConsSection extends StatelessWidget {
  final List<String> pros;
  final List<String> cons;

  const ProsAndConsSection({super.key, required this.pros, required this.cons});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.only(bottom: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                'Pros and Cons',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: 24),

              // Pros section
              if (pros.isNotEmpty) ...[
                const Text(
                  'Pros',
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: -0.16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF15803D),
                  ),
                ),
                const SizedBox(height: 12),
                ...pros.map(
                  (point) => _buildBulletPoint(
                    point,
                    icon: Icons.check,
                    iconColor: Color(0xFF12813D),
                    iconBackgroundColor: Color(0xFF16A34A).withOpacity(0.12),
                  ),
                ),
              ],

              const SizedBox(height: 34),

              // Cons section
              if (cons.isNotEmpty) ...[
                const Text(
                  'Cons',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFB45309),
                  ),
                ),
                const SizedBox(height: 12),
                ...cons.map(
                  (point) => _buildBulletPoint(
                    point,
                    icon: FontAwesomeIcons.exclamation,
                    iconColor: Color(0xFFD97706),
                    iconBackgroundColor: Color(0xFFD97706).withOpacity(0.12),
                  ),
                ),
              ],
              // const SizedBox(height: 34),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(
    String text, {
    required IconData icon,
    required Color iconColor,
    bool isCon = false,
    Color? backgroundColor,
    Color? iconBackgroundColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: iconBackgroundColor ?? iconColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 12),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: isCon ? Color(0xFF64748B) : Colors.grey[700],
                letterSpacing: 0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
