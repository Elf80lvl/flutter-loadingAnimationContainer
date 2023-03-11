import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer timer;
  double widthFull = 200;
  double width = 0.0;
  int perc = 0;

  void start() {
    if (perc == 0) {
      timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
        setState(() {
          width = width + 1;
          perc = ((width * 100) / widthFull).round();
          if (width == 200) {
            timer.cancel();
          }
        });
      });
    }
  }

  void stop() {
    setState(() {
      timer.cancel();
      width = 0.0;
      perc = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              //*BG
              Container(
                width: widthFull,
                height: 50,
                color: Colors.blue.shade200,
              ),

              //*filler
              Container(
                width: width,
                height: 50,
                color: Colors.blue,
              ),

              //*percentage
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    perc == 0 ? '' : '$perc %',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      //*play/reset button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          (timer.isActive || width == widthFull) ? stop() : start();
        },
        child: Icon(
          (timer.isActive || width == widthFull)
              ? Icons.restart_alt
              : Icons.play_arrow,
        ),
      ),
    );
  }
}
