import 'package:flutter/material.dart';

import '../../domain/entities/bond_detail.dart';

class IssuerDetailsSection extends StatelessWidget {
  final BondDetail bondDetail;

  const IssuerDetailsSection({super.key, required this.bondDetail});

  Widget _buildDetailItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
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
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade300, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.business, size: 20, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    'Issuer Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildDetailItem(
                'Issuer Name',
                bondDetail.issuerDetails.issuerName,
              ),
              _buildDetailItem(
                'Type of Issuer',
                bondDetail.issuerDetails.typeOfIssuer,
              ),
              _buildDetailItem('Non PSU', 'Non PSU'),
              _buildDetailItem('Sector', bondDetail.issuerDetails.sector),
              _buildDetailItem('Industry', bondDetail.issuerDetails.industry),
              _buildDetailItem(
                'Issuer Nature',
                bondDetail.issuerDetails.issuerNature,
              ),
              _buildDetailItem('CIN', bondDetail.issuerDetails.cin),
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
      ),
    );
  }
}
