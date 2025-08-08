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

  Widget _buildHighlightedText(String text, TextStyle baseStyle) {
    final query = widget.searchQuery.trim().toLowerCase();
    if (query.isEmpty) return Text(text, style: baseStyle);

    final queryTerms = query
        .split(RegExp(r'\s+'))
        .where((t) => t.isNotEmpty)
        .toList();
    final lowerText = text.toLowerCase();

    if (!queryTerms.any((term) => lowerText.contains(term))) {
      return Text(text, style: baseStyle);
    }

    List<HighlightMatch> allMatches = [];

    for (final term in queryTerms) {
      int startIndex = 0;
      while (true) {
        final matchIndex = lowerText.indexOf(term, startIndex);
        if (matchIndex == -1) break;
        allMatches.add(
          HighlightMatch(
            matchIndex,
            matchIndex + term.length,
            text.substring(matchIndex, matchIndex + term.length),
          ),
        );
        startIndex = matchIndex + term.length;
      }
    }

    if (allMatches.isEmpty) return Text(text, style: baseStyle);

    allMatches.sort((a, b) => a.start.compareTo(b.start));

    List<HighlightMatch> mergedMatches = [];
    for (final match in allMatches) {
      if (mergedMatches.isEmpty) {
        mergedMatches.add(match);
      } else {
        final last = mergedMatches.last;
        if (match.start <= last.end) {
          mergedMatches[mergedMatches.length - 1] = HighlightMatch(
            last.start,
            match.end > last.end ? match.end : last.end,
            text.substring(
              last.start,
              match.end > last.end ? match.end : last.end,
            ),
          );
        } else {
          mergedMatches.add(match);
        }
      }
    }

    final List<Widget> widgets = [];
    int currentPos = 0;
    for (final match in mergedMatches) {
      if (match.start > currentPos) {
        widgets.add(
          Text(text.substring(currentPos, match.start), style: baseStyle),
        );
      }
      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
            decoration: BoxDecoration(
              color: const Color(0xFFD97706).withOpacity(0.16),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              match.text,
              textAlign: TextAlign.right,
              style: baseStyle.copyWith(
                color: Colors.grey.shade900,
                fontSize: 12,
                letterSpacing: 0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
      currentPos = match.end;
    }

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
