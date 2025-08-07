import 'package:flutter/material.dart';
import 'package:tap_flutter_assignment/features/home/presentation/widgets/company_financial_section_widget.dart';
import 'package:tap_flutter_assignment/features/home/presentation/widgets/pros_and_cons_section.dart';

import '../../domain/entities/bond_detail.dart';
import 'issuer_details_section.dart';

class BondDetailHeaderSection extends StatefulWidget {
  final BondDetail bondDetail;

  const BondDetailHeaderSection({super.key, required this.bondDetail});

  @override
  State<BondDetailHeaderSection> createState() =>
      _BondDetailHeaderSectionState();
}

class _BondDetailHeaderSectionState extends State<BondDetailHeaderSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Rebuild when tab changes
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCompanyHeader(),
        SizedBox(height: 12),
        _buildTabSection(),
        SizedBox(height: 12),
        _buildSelectedTabContent(),
      ],
    );
  }

  Widget _buildCompanyHeader() {
    return Container(
      width: double.infinity,
      // color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                widget.bondDetail.logo,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: Icon(Icons.business, color: Colors.grey[400]),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            widget.bondDetail.companyName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.bondDetail.description,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6A7282),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF2563EB).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'ISIN: ${widget.bondDetail.isin}',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF2563EB),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF059669).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.bondDetail.status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF059669),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return TabBar(
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      controller: _tabController,
      indicatorColor: Colors.blue.shade800,
      indicatorWeight: 3,
      labelColor: Colors.blue.shade700,
      unselectedLabelColor: Colors.grey.shade600,
      labelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
      padding: EdgeInsets.symmetric(horizontal: 20),
      tabs: const [
        Tab(
          child: Text(
            'ISIN Analysis',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        Tab(
          child: Text(
            "Pros & Cons",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedTabContent() {
    switch (_tabController.index) {
      case 0:
        return _buildISINAnalysisTab();
      case 1:
        return ProsAndConsSection(
          pros: widget.bondDetail.prosAndCons.pros,
          cons: widget.bondDetail.prosAndCons.cons,
        );
      default:
        return _buildISINAnalysisTab();
    }
  }

  Widget _buildISINAnalysisTab() {
    return Column(
      children: [
        CompanyFinancialsSection(bondDetail: widget.bondDetail),
        const SizedBox(height: 24),
        IssuerDetailsSection(bondDetail: widget.bondDetail),
        const SizedBox(height: 20),
      ],
    );
  }
}
