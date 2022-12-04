import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:train_app/authentication/auth.dart';
import 'package:train_app/models/model_dao.dart';
import 'package:train_app/pages/boarding_pass.dart';
import 'package:train_app/pages/search_page.dart';

import '../models/location.dart';
import '../models/train.dart';
import '../widgets/train_seats.dart';
import 'home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onTap(int currentIndex) {
    setState(() {
      _selectedIndex = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    // _currentIndex = 0;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onTap,
          elevation: 0.0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                  color: Colors.blueGrey,
                ),
                label: 'Home'),
            // BottomNavigationBarItem(
            //     icon: Icon(
            //       Icons.search_outlined,
            //       color: Colors.blueGrey,
            //     ),
            //     label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.airplane_ticket_outlined,
                  color: Colors.blueGrey,
                ),
                label: 'Ticket'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.blueGrey,
                ),
                label: 'Profile')
          ]),
      body: Center(
          child: IndexedStack(
        index: _selectedIndex,
        children: pages,
      )),
    );
  }
}

List<Widget> pages = [
  const Home(),
  // const Text('Home', style: TextStyle(color: Colors.black),),
  // const Center(child: SearchPage()),
  const BoardingPassPage(),
  const AdminPage(),
];

class AdminPage extends ConsumerStatefulWidget {
  const AdminPage({super.key});

  @override
  ConsumerState<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends ConsumerState<AdminPage> {
  final locationNameController = TextEditingController();
  final locationCodeController = TextEditingController();
  final trainNameController = TextEditingController();
  final trainCodeController = TextEditingController();
  final _sourceNameController = TextEditingController();
  final _sourceCodeController = TextEditingController();
  final _destinationNameController = TextEditingController();
  final _destinationCodeController = TextEditingController();
  final _departureDateController = TextEditingController();
  final _arrivalDateController = TextEditingController();
  final _trainController = TextEditingController();
  final _priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _trainFormKey = GlobalKey<FormState>();
  final _tripFormKey = GlobalKey<FormState>();
  final _classFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    locationNameController.dispose();
    locationCodeController.dispose();
    trainCodeController.dispose();
    trainNameController.dispose();
    _sourceNameController.dispose();
    _sourceCodeController.dispose();
    _destinationCodeController.dispose();
    _destinationNameController.dispose();
    _departureDateController.dispose();
    _arrivalDateController.dispose();
    _trainController.dispose();
    _priceController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  ref.read(authenticationProvider).signOut();
                },
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors.redAccent,
                  size: 30,
                )),
          )
        ],
        backgroundColor: Colors.white,
        title: const Text(
          'Admin Corner',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                onTap: () async {
                  await _addTrain(context);
                },
                title: const Text('Add Train'),
              ),
              ListTile(
                onTap: () async {
                  await _addTrip(context);
                },
                title: const Text('Add Trip'),
              ),
              ListTile(
                onTap: () async {
                  await _addLocation(context);
                },
                title: const Text('Add Location'),
              ),
              Consumer(builder: (context, ref, child) {
                return ListTile(
                  onTap: () {
                    ref.read(daoProvider).getTrainWagons('te');
                  },
                  title: const Text('Add class'),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  _addLocation(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Form(
            key: _formKey,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10),
                    child: Text(
                      'Add Location',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please add a location';
                        }
                        return null;
                      },
                      controller: locationNameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Location Name',
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please add a location';
                        }
                        return null;
                      },
                      controller: locationCodeController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Location Code',
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final station = Location(
                            code: locationCodeController.text,
                            name: locationNameController.text,
                          );
                          await ref
                              .read(daoProvider)
                              .addLocation(station)
                              .then((value) {
                            print('done');
                            setState(() {
                              locationCodeController.clear();
                              locationNameController.clear();
                            });
                            return;
                          });
                        }
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.green, width: 2.5)),
                          child: const Text(
                            'Add Station',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  _addTrain(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Form(
            key: _trainFormKey,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10),
                    child: Text(
                      'Add Train',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please add a location';
                        }
                        return null;
                      },
                      controller: trainNameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Train Name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please add a location';
                        }
                        return null;
                      },
                      controller: trainCodeController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Train Code',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () async {
                        if (_trainFormKey.currentState!.validate()) {
                          final train = Train(
                            code: trainCodeController.text,
                            name: trainNameController.text,
                          );
                          await ref
                              .read(daoProvider)
                              .addTrain(train)
                              .then((value) {
                            setState(() {
                              trainCodeController.clear();
                              trainNameController.clear();
                            });
                            return;
                          });
                        }
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.green, width: 2.5)),
                          child: const Text(
                            'Add Train',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  _addTrip(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Form(
              key: _tripFormKey,
              child: ListView(
                children: [
                  const Text(
                    'Add Trip',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TrainFormField(
                            controller: _sourceNameController,
                            readOnly: true,
                            inValidate: 'Please add source',
                            hintText: 'From',
                            onTap: () {},
                          ),
                        ),
                        Expanded(
                          child: TrainFormField(
                            controller: _sourceCodeController,
                            readOnly: true,
                            inValidate: 'Please add source code',
                            hintText: 'source code',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TrainFormField(
                            controller: _destinationNameController,
                            readOnly: true,
                            inValidate: 'Please add your destination',
                            hintText: 'To',
                            onTap: () {},
                          ),
                        ),
                        Expanded(
                          child: TrainFormField(
                            controller: _destinationCodeController,
                            readOnly: true,
                            inValidate: 'Please add destination code',
                            hintText: 'Dest code',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TrainFormField(
                            controller: _trainController,
                            readOnly: true,
                            inValidate: 'Please add a train',
                            hintText: 'Train',
                            onTap: () {},
                          ),
                        ),
                        Expanded(
                          child: TrainFormField(
                            controller: _priceController,
                            readOnly: false,
                            inValidate: 'Please trip price',
                            hintText: 'Price',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TrainFormField(
                            controller: _departureDateController,
                            readOnly: true,
                            inValidate: 'Please add departure date',
                            hintText: 'Departure Date',
                            onTap: () {},
                          ),
                        ),
                        Expanded(
                          child: Expanded(
                            child: TrainFormField(
                              controller: _arrivalDateController,
                              readOnly: true,
                              inValidate: 'Please add arrival date',
                              hintText: 'Arrival Date',
                              onTap: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () async {
                        if (_tripFormKey.currentState!.validate()) {
                          // final train = Train(
                          //   code: trainCodeController.text,
                          //   name: trainNameController.text,
                          // );
                          // await ref
                          //     .read(daoProvider)
                          //     .addTrain(train)
                          //     .then((value) {
                          //   setState(() {
                          //     trainCodeController.clear();
                          //     trainNameController.clear();
                          //   });
                          //   return;
                          // });
                        }
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.green, width: 2.5)),
                          child: const Text(
                            'Add Train',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class TrainFormField extends StatelessWidget {
  const TrainFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.inValidate,
    required this.readOnly,
    this.onTap,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String inValidate;
  final bool readOnly;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return inValidate;
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.deepPurple,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: hintText,
      ),
    );
  }
}
