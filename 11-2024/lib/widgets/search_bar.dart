import 'package:flutter/material.dart';

class SearchBarCustom extends StatefulWidget {
  final Function(String) onSearch;

  const SearchBarCustom({super.key, required this.onSearch});

  @override
  // ignore: library_private_types_in_public_api
  _SearchBarCustomState createState() => _SearchBarCustomState();
}

class _SearchBarCustomState extends State<SearchBarCustom> {
  final TextEditingController _searchController = TextEditingController();

  void _clearSearch() {
    _searchController.clear();
    widget.onSearch(''); 
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  widget.onSearch(
                      value); 
                  setState(
                      () {});
                },
                decoration: InputDecoration(
                  hintText: 'Pesquisar...',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                ),
                style: TextStyle(fontSize: 16),
                cursorColor: Theme.of(context).primaryColor,
              ),
            ),
            if (_searchController.text.isNotEmpty)
              IconButton(
                icon: Icon(Icons.clear, color: Colors.grey),
                onPressed: _clearSearch,
              ),
          ],
        ),
      ),
    );
  }
}
