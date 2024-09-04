// splash_screen.dart////

import 'package:flutter/material.dart';
import 'grid_dimensions_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => GridDimensionsScreen()));
    });
      return Scaffold(
        backgroundColor: Colors.lightGreenAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.grid_on,
                color: Colors.white,
                size: 100.0,
              ),
              SizedBox(height: 20.0),
              Text(
                "Welcome to Word Search",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

