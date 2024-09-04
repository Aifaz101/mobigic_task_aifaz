//grid_widget.dart//

import 'package:flutter/material.dart';

class GridWidget extends StatelessWidget {
  final int m;
  final int n;
  final List<List<String>> grid;
  final List<List<bool>> highlighted;

  GridWidget({
    required this.m,
    required this.n,
    required this.grid,
    required this.highlighted,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: n,
      ),
      itemCount: m * n,
      itemBuilder: (context, index) {
        final row = index ~/ n;
        final col = index % n;
        return Container(
          margin: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: highlighted[row][col] ? Colors.green[200] : Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Center(
            child: Text(
              grid[row][col],
              style: TextStyle(
                fontSize: 20,
                color: highlighted[row][col] ? Colors.green : Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
