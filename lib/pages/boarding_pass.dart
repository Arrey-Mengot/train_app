import 'package:flutter/material.dart';
import 'package:train_app/widgets/ticket.dart';

class BoardingPassPage extends StatelessWidget {
  const BoardingPassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff03314B),
      appBar: AppBar(
        backgroundColor: const Color(0xff03314B),
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          'Boarding Pass',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: const Center(child: Ticket()),
    );
  }
}
