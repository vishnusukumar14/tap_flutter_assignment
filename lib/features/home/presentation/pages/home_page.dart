import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_flutter_assignment/features/home/domain/entities/company.dart';
import 'package:tap_flutter_assignment/features/home/presentation/cubit/company_list_cubit.dart';
import 'package:tap_flutter_assignment/features/home/presentation/cubit/company_list_state.dart';
import 'package:tap_flutter_assignment/features/home/presentation/pages/company_detail_page.dart';

import '../widgets/company_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  List<Company> _filterCompanies(List<Company> allCompanies) {
    if (_searchQuery.isEmpty) {
      return allCompanies;
    } else {
      return allCompanies.where((company) {
        return _matchesSearchQuery(company, _searchQuery);
      }).toList();
    }
  }

  bool _matchesSearchQuery(Company company, String query) {
    final normalizedQuery = query.toLowerCase().trim();
    if (normalizedQuery.isEmpty) return true;

    final isin = company.isin.toLowerCase();
    final companyName = company.companyName.toLowerCase();

    final queryTerms = normalizedQuery.split(RegExp(r'\s+'));

    return queryTerms.any((term) {
      if (term.isEmpty) return false;
      return isin.contains(term) || companyName.contains(term);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Home',
                style: TextStyle(
                  fontSize: 26,
                  letterSpacing: -0.78,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Inter",
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: 350,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                    width: 0.5,
                  ),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by Issuer Name or ISIN',
                    hintStyle: TextStyle(
                      letterSpacing: 0,
                      height: 1.5,
                      fontFamily: "Inter",
                      color: Colors.grey[400],
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[500],
                      size: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                textAlign: TextAlign.start,
                _searchQuery.isNotEmpty
                    ? 'SEARCH RESULTS'
                    : 'SUGGESTED RESULTS',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                  letterSpacing: 0.8,
                ),
              ),
            ),
            SizedBox(
              height: 217.2,
              child: BlocBuilder<CompanyListCubit, CompanyListState>(
                builder: (context, state) => _buildCompaniesList(state),
              ),
            ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildCompaniesList(CompanyListState state) {
    if (state is CompanyListLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is CompanyListError) {
      return _buildErrorState(state.message);
    }

    if (state is CompanyListLoaded) {
      final allCompanies = state.companies;
      final companiesToShow = _filterCompanies(allCompanies);

      if (companiesToShow.isEmpty && _searchQuery.isNotEmpty) {
        return _buildEmptySearchState();
      }

      if (companiesToShow.isEmpty) {
        return const Center(
          child: Text(
            'No companies available',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200, width: 0.5),
          ),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: companiesToShow.length,
            itemBuilder: (context, index) {
              final company = companiesToShow[index];
              return CompanyCard(
                company: company,
                searchQuery: _searchQuery,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CompanyDetailPage(companyId: company.isin),
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildEmptySearchState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No results found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search terms',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<CompanyListCubit>().loadCompanies();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007AFF),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
