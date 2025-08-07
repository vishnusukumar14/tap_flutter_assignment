import 'package:flutter/material.dart';

import '../../domain/entities/bond_detail.dart';

class CompanyFinancialsSection extends StatefulWidget {
  final BondDetail bondDetail;

  const CompanyFinancialsSection({super.key, required this.bondDetail});

  @override
  State<CompanyFinancialsSection> createState() =>
      _CompanyFinancialsSectionState();
}

class _CompanyFinancialsSectionState extends State<CompanyFinancialsSection> {
  bool showRevenue = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'COMPANY FINANCIALS',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              Row(
                children: [
                  _buildToggleButton('EBITDA', !showRevenue),
                  const SizedBox(width: 8),
                  _buildToggleButton('Revenue', showRevenue),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildChart(),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showRevenue = text == 'Revenue';
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildChart() {
    final data = showRevenue
        ? widget.bondDetail.financials.revenue
        : widget.bondDetail.financials.ebitda;
    final maxValue = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: data.map((item) => _buildBarItem(item, maxValue)).toList(),
      ),
    );
  }

  Widget _buildBarItem(MonthlyData data, double maxValue) {
    final normalizedHeight = (data.value / maxValue) * 100;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(width: 20, height: 100, color: Colors.blue[100]),
            Container(
              width: 20,
              height: normalizedHeight.clamp(5.0, 100.0),
              color: Colors.black,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          data.month.substring(0, 1).toUpperCase(),
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
