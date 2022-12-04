import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:train_app/models/model_dao.dart';
import 'package:train_app/pages/home.dart';
import 'package:train_app/pages/ticket_options.dart';
import 'package:train_app/widgets/ticket.dart';

import '../models/ticket.dart';

class BoardingPassPage extends ConsumerWidget {
  const BoardingPassPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripID = ref.watch(tripIDProvider);
    final ticketID = ref.watch(ticketIDProvider);
    // List<Ticket> tickets = [];

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
      body: Center(
        child: FutureBuilder<List<Ticket>>(
          future: ref.watch(daoProvider).getTrainTicketByID(tripID, ticketID),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
            ;
            // if (snapshot.data!.isEmpty) {
            //   return Text("Document does not exist");
            // }
            // ;
            if (snapshot.connectionState == ConnectionState.done) {
              List<Ticket> tickets = snapshot.data!;
              return TicketCard(
                agency: ref.watch(trainIDProvider).toUpperCase(),
                location: '',
                source: ref.watch(sourceProvider),
                destination: ref.watch(destinationProvider),
                sourceCode: ref.watch(fromCodeProvider),
                destinationCode: ref.watch(toCodeProvider),
                departureDate: ref.watch(departureDateProvider),
                arrivalDate: ref.watch(arrivalDateProvider),
                departureTime: '',
                arrivalTime: '',
                duration: ref.watch(durationProvider),
                trainCode: ref.watch(trainIDProvider).toUpperCase(),
                ticketClass:
                    tickets.isEmpty ? '' : tickets[0].totalPrice.toString(),
                ticketID: tickets.isEmpty ? '' : tickets[0].ticketID,
                passengers: tickets.isEmpty ? '' : tickets[0].passengers![0],
                seat: tickets.isEmpty ? '' : tickets[0].seats![0],
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
