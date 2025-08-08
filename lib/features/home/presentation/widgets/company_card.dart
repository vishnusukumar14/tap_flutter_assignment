import 'package:flutter/material.dart';

import '../../domain/entities/company.dart';

class HighlightMatch {
  final int start;
  final int end;
  final String text;

  HighlightMatch(this.start, this.end, this.text);
}

class CompanyCard extends StatefulWidget {
  final Company company;
  final String searchQuery;
  final VoidCallback onTap;

  const CompanyCard({
    super.key,
    required this.company,
    required this.searchQuery,
    required this.onTap,
  });

  @override
  State<CompanyCard> createState() => _CompanyCardState();
}

class _CompanyCardState extends State<CompanyCard>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Enhanced helper method to create highlighted text with rounded corners
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

    // Build a Row with highlighted containers
    final List<Widget> widgets = [];
    int currentPos = 0;

    for (final match in mergedMatches) {
      // Add text before match
      if (match.start > currentPos) {
        widgets.add(
          Text(text.substring(currentPos, match.start), style: baseStyle),
        );
      }

      // Add highlighted match with rounded corners and padding
      widgets.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            color: const Color(0xFFD97706).withOpacity(0.16),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text.substring(match.start, match.end),
            style: baseStyle.copyWith(
              // color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );

      currentPos = match.end;
    }

    // Add remaining text
    if (currentPos < text.length) {
      widgets.add(Text(text.substring(currentPos), style: baseStyle));
    }

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200, width: 0.5),
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.network(
              widget.company.logo,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.business,
                    color: Colors.grey[500],
                    size: 20,
                  ),
                );
              },
            ),
          ),
        ),
        title: Row(
          children: [
            Flexible(
              child: _buildHighlightedText(
                widget.company.isin.substring(
                  0,
                  widget.company.isin.length - 4,
                ),
                TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Flexible(
              child: _buildHighlightedText(
                widget.company.isin.substring(widget.company.isin.length - 4),
                TextStyle(
                  color: Colors.grey[800],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.company.rating} • ",
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: "Inter",
                  color: Colors.grey[400],
                  letterSpacing: 0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                child: _buildHighlightedText(
                  widget.company.companyName,
                  TextStyle(
                    fontSize: 10,
                    fontFamily: "Inter",
                    letterSpacing: 0,
                    color: Colors.grey[400],
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
          color: Colors.blue[700],
        ),
        onTap: widget.onTap,
      ),
    );
  }
}
