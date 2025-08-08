import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain/entities/company_detail.dart';

class IssuerDetailsSection extends StatelessWidget {
  final CompanyDetail companyDetail;

  const IssuerDetailsSection({super.key, required this.companyDetail});

  Widget _buildDetailItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue[700],
              letterSpacing: 0,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              letterSpacing: 0,
              color: Colors.grey[900],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.addressBook,
                  size: 20,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  'Issuer Details',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF020617),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Divider(thickness: 0.8, color: Colors.grey.shade200),
          const SizedBox(height: 8),
          _buildDetailItem(
            'Issuer Name',
            companyDetail.issuerDetails.issuerName,
          ),
          _buildDetailItem(
            'Type of Issuer',
            companyDetail.issuerDetails.typeOfIssuer,
          ),
          _buildDetailItem('Sector', companyDetail.issuerDetails.sector),
          _buildDetailItem('Industry', companyDetail.issuerDetails.industry),
          _buildDetailItem(
            'Issuer Nature',
            companyDetail.issuerDetails.issuerNature,
          ),
          _buildDetailItem(
            'Corporate Identity Number (CIN)',
            companyDetail.issuerDetails.cin,
          ),
          _buildDetailItem(
            'Name of the Lead Manager',
            companyDetail.issuerDetails.leadManager,
          ),
          _buildDetailItem('Registrar', companyDetail.issuerDetails.registrar),
          _buildDetailItem(
            'Name of Debenture Trustee',
            companyDetail.issuerDetails.debentureTrustee,
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade200, width: 0.5),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start),
      ),
    );
  }
}
