import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain/entities/bond_detail.dart';

class IssuerDetailsSection extends StatelessWidget {
  final BondDetail bondDetail;

  const IssuerDetailsSection({super.key, required this.bondDetail});

  Widget _buildDetailItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
              ),
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
            Divider(thickness: 0.8),
            const SizedBox(height: 16),
            _buildDetailItem(
              'Issuer Name',
              bondDetail.issuerDetails.issuerName,
            ),
            _buildDetailItem(
              'Type of Issuer',
              bondDetail.issuerDetails.typeOfIssuer,
            ),
            _buildDetailItem('Sector', bondDetail.issuerDetails.sector),
            _buildDetailItem('Industry', bondDetail.issuerDetails.industry),
            _buildDetailItem(
              'Issuer Nature',
              bondDetail.issuerDetails.issuerNature,
            ),
            _buildDetailItem(
              'Corporate Identity Number (CIN)',
              bondDetail.issuerDetails.cin,
            ),
            _buildDetailItem(
              'Name of the Lead Manager',
              bondDetail.issuerDetails.leadManager,
            ),
            _buildDetailItem('Registrar', bondDetail.issuerDetails.registrar),
            _buildDetailItem(
              'Name of Debenture Trustee',
              bondDetail.issuerDetails.debentureTrustee,
            ),
          ],
        ),
      ),
    );
  }
}
