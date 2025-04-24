import 'dart:ui'; // BackdropFilter uchun

import 'package:flutter/material.dart';
import 'convert_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF42A5F5), // Ko'k rangning ochroq varianti
                Color(0x590331), // Ko'k rangning to'qroq varianti
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Xush kelibsiz matni
                Text(
                  'Valyuta tarjimoni ilovasiga xush kelibsiz!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Ilova haqida qisqacha ma'lumot
                Text(
                  'Oz\'bek, AQSH, Rus, Yevropa, Rossiya, Qirg\'iziston va Tojikiston valyutalarini tezda va osonlik bilan konvertatsiya qiling.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // "Hoziroq ishga tushiring!" tugmasi va icon
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent, // Shaffof fon
                      barrierColor: Colors.transparent, // Shaffof to'siq
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) => BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Blur effekti
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8), // Modalning foni
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          child: const ConverterScreen(),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Hoziroq ishga tushiring!',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.flash_on, color: Colors.white),
                    ],
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