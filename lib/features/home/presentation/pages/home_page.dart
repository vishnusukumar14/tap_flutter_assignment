import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_flutter_assignment/features/home/domain/entities/bond.dart';
import 'package:tap_flutter_assignment/features/home/presentation/cubit/bond_cubit.dart';
import 'package:tap_flutter_assignment/features/home/presentation/cubit/bond_list_state.dart';
import 'package:tap_flutter_assignment/features/home/presentation/pages/company_detail_page.dart';

import '../widgets/bond_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Bond> _filteredBonds = [];
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

  List<Bond> _filterBonds(List<Bond> allBonds) {
    if (_searchQuery.isEmpty) {
      return allBonds;
    } else {
      return allBonds.where((bond) {
        return _matchesSearchQuery(bond, _searchQuery);
      }).toList();
    }
  }

  bool _matchesSearchQuery(Bond bond, String query) {
    final normalizedQuery = query.toLowerCase().trim();
    final isin = bond.isin.toLowerCase();
    final companyName = bond.companyName.toLowerCase();

    // Split query into individual words/terms
    final queryTerms = normalizedQuery.split(RegExp(r'\s+'));

    // Check if all terms match either ISIN or company name
    for (final term in queryTerms) {
      if (term.isEmpty) continue;

      bool termMatches = false;

      // Check if term matches in ISIN
      if (isin.contains(term)) {
        termMatches = true;
      }

      if (companyName.contains(term)) {
        termMatches = true;
      }

      final combined = '$isin $companyName';
      if (combined.contains(term)) {
        termMatches = true;
      }

      if (!termMatches) {
        return false;
      }
    }

    return true;
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
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by Issuer Name or ISIN',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
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
            // Scrollable content section
            SizedBox(
              height: 216,
              child: BlocBuilder<BondCubit, BondListState>(
                builder: (context, state) => _buildBondsList(state),
              ),
            ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildBondsList(BondListState state) {
    // Handle loading state
    if (state is BondListLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Handle error state
    if (state is BondListError) {
      return _buildErrorState(state.message);
    }

    // Handle loaded state
    if (state is BondListLoaded) {
      final allBonds = state.bonds;
      final bondsToShow = _filterBonds(allBonds);

      if (bondsToShow.isEmpty && _searchQuery.isNotEmpty) {
        return _buildEmptySearchState();
      }

      if (bondsToShow.isEmpty) {
        return const Center(
          child: Text(
            'No bonds available',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200, width: 1),
          ),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: bondsToShow.length,
            itemBuilder: (context, index) {
              final bond = bondsToShow[index];
              return SearchableBondCard(
                bond: bond,
                searchQuery: _searchQuery,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BondDetailPage(bondId: bond.isin),
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
    }

    // Handle initial/unknown state
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
              context.read<BondCubit>().loadBonds();
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

class HighlightMatch {
  final int start;
  final int end;
  final String text;

  HighlightMatch(this.start, this.end, this.text);
}
