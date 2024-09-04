//grid_dimension_screen.dart//

import 'package:flutter/material.dart';
import 'grid_input_screen.dart';

class GridDimensionsScreen extends StatefulWidget {
  @override
  _GridDimensionsScreenState createState() => _GridDimensionsScreenState();
}

class _GridDimensionsScreenState extends State<GridDimensionsScreen> {
  void _showDimensionsDialog() {
    final _rowController = TextEditingController();
    final _colController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Grid Dimensions'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _rowController,
                decoration: InputDecoration(labelText: 'Number of rows'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _colController,
                decoration: InputDecoration(labelText: 'Number of columns'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                final m = int.tryParse(_rowController.text);
                final n = int.tryParse(_colController.text);

                if (m != null && n != null && m > 0 && n > 0) {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GridInputScreen(m: m, n: n),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter valid dimensions')));
                }
              },
              child: Text('Create Grid'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Grid Dimensions')),
      body: Center(
        child: ElevatedButton(
          onPressed: _showDimensionsDialog,
          child: Text('Enter Grid Dimensions'),
        ),
      ),
    );
  }
}
