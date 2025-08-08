import 'package:flutter/material.dart';

class FinancialToggleSwitch extends StatefulWidget {
  final bool initialShowRevenue;
  final void Function(bool isRevenue) onChanged;

  const FinancialToggleSwitch({
    super.key,
    this.initialShowRevenue = false,
    required this.onChanged,
  });

  @override
  State<FinancialToggleSwitch> createState() => _FinancialToggleSwitchState();
}

class _FinancialToggleSwitchState extends State<FinancialToggleSwitch> {
  late bool showRevenue;

  @override
  void initState() {
    super.initState();
    showRevenue = widget.initialShowRevenue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 25,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          _buildToggleButton('EBITDA', !showRevenue),
          _buildToggleButton('Revenue', showRevenue),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected) {
    final isRevenueButton = text == 'Revenue';

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            showRevenue = isRevenueButton;
          });
          widget.onChanged(showRevenue);
        },
        child: Container(
          height: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: isRevenueButton
                ? const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: const Offset(0, 1),
                      blurRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? const Color(0xFF171717)
                  : const Color(0xFF737373),
            ),
          ),
        ),
      ),
    );
  }
}
