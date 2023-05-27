import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(SaatUygulamasi());

class SaatUygulamasi extends StatefulWidget {
  @override
  _SaatUygulamasiState createState() => _SaatUygulamasiState();
}

class _SaatUygulamasiState extends State<SaatUygulamasi> {
  int hour = 10;
  int minute = 15;
  int second = 0;
  Timer? timer;

  void resetTime() {
    setState(() {
      hour = 10;
      minute = 15;
      second = 0;
    });
    stopTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        second++;
        if (second >= 60) {
          second = 0;
          minute++;
          if (minute >= 60) {
            minute = 0;
            hour++;
            if (hour >= 24) {
              hour = 0;
            }
          }
        }
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String suan = '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';

    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                suan,
                style: TextStyle(
                  fontSize: 200,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      resetTime();
                    },
                    child: Text('Sıfırla'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: () {
                      if (timer != null && timer!.isActive) {
                        stopTimer();
                      } else {
                        startTimer();
                      }
                    },
                    child: Text(timer != null && timer!.isActive ? 'Durdur' : 'Başlat'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}