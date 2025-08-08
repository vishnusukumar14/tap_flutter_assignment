import 'package:flutter/material.dart';
import 'package:tap_flutter_assignment/features/home/presentation/widgets/company_financial_section_widget.dart';
import 'package:tap_flutter_assignment/features/home/presentation/widgets/pros_and_cons_section.dart';

import '../../domain/entities/company_detail.dart';
import 'issuer_details_section.dart';

class CompanyDetailHeaderSection extends StatefulWidget {
  final CompanyDetail companyDetail;

  const CompanyDetailHeaderSection({super.key, required this.companyDetail});

  @override
  State<CompanyDetailHeaderSection> createState() =>
      _CompanyDetailHeaderSectionState();
}

class _CompanyDetailHeaderSectionState extends State<CompanyDetailHeaderSection>
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
                widget.companyDetail.logo,
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
            widget.companyDetail.companyName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.companyDetail.description,
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
                  'ISIN: ${widget.companyDetail.isin}',
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
                  widget.companyDetail.status.toUpperCase(),
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
          pros: widget.companyDetail.prosAndCons.pros,
          cons: widget.companyDetail.prosAndCons.cons,
        );
      default:
        return _buildISINAnalysisTab();
    }
  }

  Widget _buildISINAnalysisTab() {
    return Column(
      children: [
        CompanyFinancialsSection(companyDetail: widget.companyDetail),
        const SizedBox(height: 24),
        IssuerDetailsSection(companyDetail: widget.companyDetail),
        const SizedBox(height: 20),
      ],
    );
  }
}
