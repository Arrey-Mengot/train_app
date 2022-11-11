import 'itinerary.dart';
import 'location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';

class Dao{
  final db = FirebaseFirestore.instance;

  Stream get allCities => db.collection('locations').snapshots();
  
 Future<List<Location>> getLocations() async {
    final List<Location> locs = [];
    //Use our from and to methods here to convert from and to firebase objects
    final ref = db.collection('locations').withConverter(
        fromFirestore: Location.fromFirestore,
        toFirestore: (Location location, _)=> location.toFireStore()
    );
    await ref.get().then((value) {
      for (var element in value.docs) {
        locs.add(element.data());
      }}   );

    return locs ;
  }

  Future<List<Itinerary>> getItinerary(String source, String destination, DateTime date) async {
      final List<Itinerary> trips = [];
      final ref = db.collection('trips').withConverter(
          fromFirestore: Itinerary.fromFirestore,
          toFirestore:(Itinerary itinerary, options) => itinerary.toFireStore()
      );
      await ref.where("source",isEqualTo:source.toLowerCase() ).where("destination",isEqualTo:destination.toLowerCase() ).get().then((value) {
        for (var element in value.docs) {
          trips.add(element.data());
        }}   );

      return trips ;
  }
}

// final  getCityProvider = Provider<List<Location>>((ref) {
//    Dao().getLocations().then(
//            (value) {
//              return value;
//            }
//    );
//
// });

final daoProvider = Provider<Dao>((ref) {
  return Dao();
});

//.where("departureDate",isEqualTo:Timestamp.fromDate(date) )
