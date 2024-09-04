//grid_input_screen.dart//

import 'package:flutter/material.dart';
import 'grid_display_screen.dart';
import '../widgets/grid_widget.dart';

class GridInputScreen extends StatefulWidget {
  final int m;
  final int n;

  GridInputScreen({required this.m, required this.n});

  @override
  _GridInputScreenState createState() => _GridInputScreenState();
}

class _GridInputScreenState extends State<GridInputScreen> {
  late List<List<TextEditingController>> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.m,
          (_) => List.generate(widget.n, (_) => TextEditingController()),
    );
  }

  void _showGridValuesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Grid Values'),
          content: Container(
            width: double.maxFinite,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.n,
              ),
              itemCount: widget.m * widget.n,
              itemBuilder: (context, index) {
                final row = index ~/ widget.n;
                final col = index % widget.n;
                return Padding(
                  padding: EdgeInsets.all(4.0),
                  child: TextField(
                    controller: _controllers[row][col],
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      counterText: '',
                    ),
                  ),
                );
              },
              shrinkWrap: true,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GridDisplayScreen(
                      m: widget.m,
                      n: widget.n,
                      controllers: _controllers,
                    ),
                  ),
                );
              },
              child: Text('Show Grid'),
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
      appBar: AppBar(title: Text('Enter Grid Values')),
      body: Center(
        child: ElevatedButton(
          onPressed: _showGridValuesDialog,
          child: Text('Enter Grid Values'),
        ),
      ),
    );
  }
}
