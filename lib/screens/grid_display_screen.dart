//grid_display_screen.dart//

import 'package:flutter/material.dart';
import '../widgets/grid_widget.dart';

class GridDisplayScreen extends StatefulWidget {
  final int m;
  final int n;
  final List<List<TextEditingController>> controllers;

  GridDisplayScreen({required this.m, required this.n, required this.controllers});

  @override
  _GridDisplayScreenState createState() => _GridDisplayScreenState();
}

class _GridDisplayScreenState extends State<GridDisplayScreen> {
  late List<List<String>> _grid;
  late List<List<bool>> _highlighted;

  @override
  void initState() {
    super.initState();
    _grid = List.generate(
      widget.m,
          (i) => List.generate(widget.n, (j) => widget.controllers[i][j].text.toUpperCase()),
    );
    _highlighted = List.generate(
      widget.m,
          (_) => List.generate(widget.n, (_) => false),
    );
  }

  void _showSearchDialog() {
    final _searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Text to Search'),
          content: TextField(
            controller: _searchController,
            onChanged: (text) => _searchText(text),
            decoration: InputDecoration(
              labelText: 'Search text',
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _searchText(String text) {
    setState(() {
      text = text.toUpperCase();
      if (text.isEmpty) return;

      // Reset highlights
      _highlighted = List.generate(
        widget.m,
            (_) => List.generate(widget.n, (_) => false),
      );

      bool found = false;
      for (int i = 0; i < widget.m; i++) {
        for (int j = 0; j < widget.n; j++) {
          if (_searchFromPosition(i, j, text)) {
            found = true;
          }
        }
      }

      if (!found) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Text not found in the grid')));
      }
    });
  }

  bool _searchFromPosition(int row, int col, String word) {
    bool match = false;

    // Check horizontally (east)
    if (col + word.length <= widget.n) {
      match = true;
      for (int k = 0; k < word.length; k++) {
        if (_grid[row][col + k] != word[k]) {
          match = false;
          break;
        }
      }
      if (match) {
        for (int k = 0; k < word.length; k++) {
          _highlighted[row][col + k] = true;
        }
      }
    }

    // Check vertically (south)
    if (row + word.length <= widget.m) {
      match = true;
      for (int k = 0; k < word.length; k++) {
        if (_grid[row + k][col] != word[k]) {
          match = false;
          break;
        }
      }
      if (match) {
        for (int k = 0; k < word.length; k++) {
          _highlighted[row + k][col] = true;
        }
      }
    }

    // Check diagonally (south-east)
    if (row + word.length <= widget.m && col + word.length <= widget.n) {
      match = true;
      for (int k = 0; k < word.length; k++) {
        if (_grid[row + k][col + k] != word[k]) {
          match = false;
          break;
        }
      }
      if (match) {
        for (int k = 0; k < word.length; k++) {
          _highlighted[row + k][col + k] = true;
        }
      }
    }

    return match;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Grid Display')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: GridWidget(
                m: widget.m,
                n: widget.n,
                grid: _grid,
                highlighted: _highlighted,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showSearchDialog,
              child: Text('Search Text'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
