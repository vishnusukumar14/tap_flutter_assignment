import 'package:flutter/material.dart';

import '../../domain/entities/bond_detail.dart';
import 'company_financial_section_widget.dart';
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
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCompanyHeader(),
          SizedBox(height: 12),
          _buildTabSection(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildCompanyHeader() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(widget.bondDetail.logo, fit: BoxFit.cover),
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
          Row(
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
              const SizedBox(width: 12),
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
    return Container(
      // width: double.,
      // width: double.infinity,
      // color: Colors.white,
      alignment: Alignment.centerLeft,
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        controller: _tabController,
        // labelPadding: EdgeInsets.symmetric(
        //   horizontal: 20,
        // ), // spacing between tabs// spacing between tabs
        indicatorColor: Colors.blue.shade800,
        indicatorWeight: 3,
        labelColor: Colors.blue.shade700,
        unselectedLabelColor: Colors.grey.shade600,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
        tabs: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'ISIN Analysis',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Pros & Cons",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SizedBox(
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildISINAnalysisTab(),
          Center(child: Text('Pros & Cons Coming Soon')),
        ],
      ),
    );
  }

  Widget _buildISINAnalysisTab() {
    return Column(
      children: [
        // CompanyFinancialsSection(bondDetail: widget.bondDetail),
        Placeholder(),
        const SizedBox(height: 20),
        IssuerDetailsSection(bondDetail: widget.bondDetail),
      ],
    );
  }
}
