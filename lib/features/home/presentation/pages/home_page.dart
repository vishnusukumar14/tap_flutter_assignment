import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_flutter_assignment/features/home/domain/entities/bond.dart';
import 'package:tap_flutter_assignment/features/home/presentation/cubit/bond_cubit.dart';
import 'package:tap_flutter_assignment/features/home/presentation/cubit/bond_list_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Bond> _allBonds = [];
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
      _filterBonds();
    });
  }

  void _filterBonds() {
    if (_searchQuery.isEmpty) {
      _filteredBonds = List.from(_allBonds);
    } else {
      _filteredBonds = _allBonds.where((bond) {
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

      // Check if term matches in company name
      if (companyName.contains(term)) {
        termMatches = true;
      }

      // Check if term matches across ISIN + company name combined
      final combined = '$isin $companyName';
      if (combined.contains(term)) {
        termMatches = true;
      }

      // If any term doesn't match, exclude this bond
      if (!termMatches) {
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        title: const Text(
          'Home',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFF007AFF)),
        ),
      ),
      body: BlocConsumer<BondCubit, BondListState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {},
            loaded: (bonds, df, dfd) {
              // Update bonds when loaded from cubit
              setState(() {
                _allBonds = bonds;
                _filterBonds();
              });
            },
            error: (message) {},
          );
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 350,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        size: 20,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                _searchController.clear();
                              },
                              child: Icon(
                                Icons.clear,
                                color: Colors.grey[500],
                                size: 20,
                              ),
                            )
                          : null,
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
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              // Results Section
              Expanded(
                child: state.when(
                  initial: () => const Center(child: Text('Welcome')),
                  loading: () => const Center(
                    child: CircularProgressIndicator(color: Color(0xFF007AFF)),
                  ),
                  loaded: (bonds, df, dfd) => _buildBondsList(),
                  error: (message) => _buildErrorState(message),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBondsList() {
    final bondsToShow = _searchQuery.isNotEmpty ? _filteredBonds : _allBonds;

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
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListView.builder(
          // padding: const EdgeInsets.symmetric(horizontal: 16.0),
          // padding: const EdgeInsets.only(bottom: 20),
          itemCount: bondsToShow.length,
          itemBuilder: (context, index) {
            final bond = bondsToShow[index];
            return SearchableBondCard(
              bond: bond,
              searchQuery: _searchQuery,
              onTap: () {
                // Handle bond selection
                print('Selected: ${bond.companyName}');
              },
            );
          },
        ),
      ),
    );
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

// Custom Match class for highlighting
class HighlightMatch {
  final int start;
  final int end;
  final String text;

  HighlightMatch(this.start, this.end, this.text);
}

// Enhanced Bond Card with Search Highlighting
class SearchableBondCard extends StatefulWidget {
  final Bond bond;
  final String searchQuery;
  final VoidCallback onTap;

  const SearchableBondCard({
    super.key,
    required this.bond,
    required this.searchQuery,
    required this.onTap,
  });

  @override
  State<SearchableBondCard> createState() => _SearchableBondCardState();
}

class _SearchableBondCardState extends State<SearchableBondCard>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  // Enhanced helper method to create highlighted text with multiple terms
  Widget _buildHighlightedText(String text, TextStyle baseStyle) {
    if (widget.searchQuery.isEmpty) {
      return Text(text, style: baseStyle);
    }

    final query = widget.searchQuery.toLowerCase().trim();
    final queryTerms = query.split(RegExp(r'\s+'));
    final lowerText = text.toLowerCase();

    // Check if any terms match in this text
    bool hasMatch = queryTerms.any(
      (term) => term.isNotEmpty && lowerText.contains(term),
    );

    if (!hasMatch) {
      return Text(text, style: baseStyle);
    }

    // Create a list of all matches with their positions
    List<HighlightMatch> allMatches = [];

    for (final term in queryTerms) {
      if (term.isEmpty) continue;

      int start = 0;
      while (true) {
        final index = lowerText.indexOf(term, start);
        if (index == -1) break;

        allMatches.add(
          HighlightMatch(
            index,
            index + term.length,
            text.substring(index, index + term.length),
          ),
        );
        start = index + 1;
      }
    }

    if (allMatches.isEmpty) {
      return Text(text, style: baseStyle);
    }

    // Sort matches by start position
    allMatches.sort((a, b) => a.start.compareTo(b.start));

    // Merge overlapping matches
    List<HighlightMatch> mergedMatches = [];
    for (final match in allMatches) {
      if (mergedMatches.isEmpty) {
        mergedMatches.add(match);
      } else {
        final lastMatch = mergedMatches.last;
        if (match.start <= lastMatch.end) {
          // Overlapping or adjacent - extend the last match
          final newEnd = match.end > lastMatch.end ? match.end : lastMatch.end;
          mergedMatches[mergedMatches.length - 1] = HighlightMatch(
            lastMatch.start,
            newEnd,
            text.substring(lastMatch.start, newEnd),
          );
        } else {
          mergedMatches.add(match);
        }
      }
    }

    // Build TextSpans
    final List<TextSpan> spans = [];
    int currentPos = 0;

    for (final match in mergedMatches) {
      // Add text before match
      if (match.start > currentPos) {
        spans.add(
          TextSpan(
            text: text.substring(currentPos, match.start),
            style: baseStyle,
          ),
        );
      }

      // Add highlighted match
      spans.add(
        TextSpan(
          text: text.substring(match.start, match.end),
          style: baseStyle.copyWith(
            backgroundColor: const Color(0xFF007AFF).withOpacity(0.2),
            fontWeight: FontWeight.w700,
          ),
        ),
      );

      currentPos = match.end;
    }

    // Add remaining text
    if (currentPos < text.length) {
      spans.add(TextSpan(text: text.substring(currentPos), style: baseStyle));
    }

    return RichText(
      text: TextSpan(children: spans),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.onTap,
        child: ListTile(
          // contentPadding: const EdgeInsets.all(16),
          leading: Container(
            width: 40,
            height: 40,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 0.6),
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.network(widget.bond.logo, fit: BoxFit.cover),
            ),
          ),
          title: Row(
            children: [
              _buildHighlightedText(
                widget.bond.isin.substring(0, widget.bond.isin.length - 4),
                const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              _buildHighlightedText(
                widget.bond.isin.substring(widget.bond.isin.length - 4),
                TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                Text(
                  'AAA • ',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildHighlightedText(
                    widget.bond.companyName,
                    TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }
}
