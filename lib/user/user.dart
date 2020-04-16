import 'package:flutter/material.dart';
import '../home/home.dart';

class UserPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green[300],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'User',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 80,
                  width: 200,
                  color: Colors.black,
                  child: RaisedButton(
                    child: Icon(
                      Icons.arrow_back,
                      size: 80,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
