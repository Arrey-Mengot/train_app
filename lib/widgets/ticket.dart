import 'package:flutter/material.dart';
import 'package:train_app/widgets/train_card.dart';

class Ticket extends StatelessWidget {
  const Ticket({super.key});

  @override
  Widget build(BuildContext context) {
    const String agency = 'Touristic Express';
    const String location = 'Yde-Mvan';
    const String source = 'Yaounde';
    const String destination = 'Douala';
    const String sourceCode = 'YDE';
    const String destinationCode = 'DLA';
    const String departureDate = '2022-12-28';
    const String departureTime = '06:15 AM';
    const String arrivalDate = '2022-12-28';
    const String arrivalTime = '06:15 AM';
    const String duration = '3h 45m';
    const String trainCode = 'LT306';
    const String ticketClass = 'Buisiness';
    const String ticketID = 'A098674';
    const String passengers = '1 Adult';
    const String seat = 'Wagon:2 / Seat:22';
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.7,
      // padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.7,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          child: Icon(Icons.train_outlined, size: 25),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(agency,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff03314B))),
                            SizedBox(
                              height: 5,
                            ),
                            Text(location,
                                style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    color: Color(0xff03314B)))
                          ],
                        )
                      ],
                    ),
                    const Divider(
                      height: 45,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            source,
                            style: TextStyle(
                                fontWeight: FontWeight.w200,
                                color: Colors.grey),
                          ),
                          Text(destination,
                              style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: Colors.grey))
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        const SourceTODestination(
                            fromCode: sourceCode, toCode: destinationCode),
                        Icon(Icons.train, color: Colors.grey.withOpacity(0.6))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            departureDate,
                            style: TextStyle(
                                fontWeight: FontWeight.w200,
                                color: Colors.grey),
                          ),
                          Text(arrivalDate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: Colors.grey)),
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            departureTime,
                            style: TextStyle(
                                fontWeight: FontWeight.w200,
                                color: Colors.grey),
                          ),
                          Text(duration,
                              style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: Colors.grey)),
                          Text(arrivalTime,
                              style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: Colors.grey)),
                        ]),
                    const Divider(
                      height: 45,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Train No",
                              style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: Colors.grey),
                            ),
                            Text(
                              trainCode,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff03314B)),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Class",
                              style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: Colors.grey),
                            ),
                            Text(
                              ticketClass,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff03314B)),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Ticket ID",
                              style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: Colors.grey),
                            ),
                            Text(
                              ticketID,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff03314B)),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Divider(
                      height: 45,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Passenger",
                              style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: Colors.grey),
                            ),
                            Text(
                              passengers,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff03314B)),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              "Seat",
                              style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: Colors.grey),
                            ),
                            Text(
                              seat,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff03314B)),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
          Positioned(
            bottom: 150,
            left: -10.0,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xff03314B),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 3,
                  color: const Color(0xff03314B),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 150,
            right: -12.0,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xff03314B),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 3,
                  color: const Color(0xff03314B),
                ),
              ),
            ),
          ),
          // const Positioned(
          //   bottom: 0,
          //   child: Divider(
          //     indent: 20,
          //     endIndent: 20,
          //     thickness: 8,
          //     height: 10,
          //   ),
          // ),
        ],
      ),
    );
  }
}
