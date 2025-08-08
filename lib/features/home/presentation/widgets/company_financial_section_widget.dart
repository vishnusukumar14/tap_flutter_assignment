import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import '../../domain/entities/company_detail.dart';
import 'financial_toggle_switch.dart';

class CompanyFinancialsSection extends StatefulWidget {
  final CompanyDetail companyDetail;

  const CompanyFinancialsSection({super.key, required this.companyDetail});

  @override
  State<CompanyFinancialsSection> createState() =>
      _CompanyFinancialsSectionState();
}

class _CompanyFinancialsSectionState extends State<CompanyFinancialsSection> {
  bool showRevenue = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'COMPANY FINANCIALS',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      // color: Colors.grey[400],
                      color: Color(0xFFA3A3A3),
                      letterSpacing: 0.8,
                    ),
                  ),

                  FinancialToggleSwitch(
                    initialShowRevenue: false,
                    onChanged: (bool isRevenue) async {
                      if (await Vibration.hasVibrator() &&
                          await Vibration.hasAmplitudeControl()) {
                        Vibration.vibrate(
                          // amplitude: 1/,
                          duration: 12,
                          sharpness: 0.04,
                        );
                      }
                      setState(() {
                        showRevenue = isRevenue;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '2024 - 2025',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Chart
              SizedBox(height: 200, child: _buildChart()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChart() {
    final revenueData = widget.companyDetail.financials.revenue;
    final ebitdaData = widget.companyDetail.financials.ebitda;

    final maxRevenue = _getMaxValue(revenueData);
    final maxEbitda = _getMaxValue(ebitdaData);
    final maxY = (maxRevenue > maxEbitda ? maxRevenue : maxEbitda) * 1.1;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceEvenly,
        maxY: maxY,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (double value, TitleMeta meta) {
                if (value.toInt() < revenueData.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      revenueData[value.toInt()].month
                          .substring(0, 1)
                          .toUpperCase(),
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: maxY / 4,
              reservedSize: 45,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    _formatValue(value),
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          drawHorizontalLine: true,
          horizontalInterval: maxY / 4,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) =>
              FlLine(color: Colors.grey[100]!, strokeWidth: 1),
          getDrawingVerticalLine: (value) {
            if (_isYearBoundary(value.toInt(), revenueData)) {
              return FlLine(
                color: Colors.grey[200]!,
                strokeWidth: 1,
                dashArray: [3, 3],
              );
            }
            return FlLine(color: Colors.transparent, strokeWidth: 0);
          },
        ),
        barGroups: List.generate(revenueData.length, (index) {
          final revenue = revenueData[index].value;
          final ebitda = ebitdaData[index].value;

          List<BarChartRodStackItem> stackItems = [];
          Color? color;

          if (showRevenue) {
            // Full solid blue bar
            color = Colors.blue[600]!;
          } else {
            // Grey background with black EBITDA overlay
            color = null;
            stackItems = [
              BarChartRodStackItem(0, ebitda, Colors.black87),
              BarChartRodStackItem(ebitda, revenue, Colors.grey[300]!),
            ];
          }

          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: revenue,
                width: 16,
                rodStackItems: stackItems,
                color: color,
                borderRadius: BorderRadius.circular(2),
                backDrawRodData: BackgroundBarChartRodData(show: false),
              ),
            ],
          );
        }),
      ),
    );
  }

  double _getMaxValue(List<MonthlyData> data) {
    return data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
  }

  String _formatValue(double value) {
    if (value == 0) return '₹0';
    if (value >= 10000000) return '₹${(value / 10000000).toStringAsFixed(0)}Cr';
    if (value >= 100000) return '₹${(value / 100000).toStringAsFixed(0)}L';
    if (value >= 1000) return '₹${(value / 1000).toStringAsFixed(0)}K';
    return '₹${value.toStringAsFixed(0)}';
  }

  bool _isYearBoundary(int index, List<MonthlyData> data) {
    if (index < 0 || index >= data.length) return false;
    if (index == 0) return true;
    if (index > 0 &&
        data[index - 1].month.toLowerCase().contains('dec') &&
        data[index].month.toLowerCase().contains('jan')) {
      return true;
    }
    if (index == data.length - 1) return true;
    return false;
  }
}
