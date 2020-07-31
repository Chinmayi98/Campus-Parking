import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing/models/report.dart';
import 'package:testing/models/user.dart';

class DatabaseService {

final String uid;
DatabaseService({this.uid});

// Collection reference
final CollectionReference reportCollection = Firestore.instance.collection('reports');

Future updateUserData(String vehicleId, String desc) async {
  return await reportCollection.document(uid).setData({
    'Vehicle ID': vehicleId,
    'Description': desc,
  });
}

// Report list from snapshot
List<Report> _reportListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.documents.map((doc){
    return Report(
      vehicleId: doc.data['Vehicle ID'] ?? '',
      desc: doc.data['Description'] ?? '',
    );
  }).toList();
}
  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      vehicleId: snapshot.data['vehicleId'],
      desc: snapshot.data['desc'],
    );
  }

 // Get records stream
 Stream<List<Report>> get reports {
   return reportCollection.snapshots()
   .map(_reportListFromSnapshot);
 }

 // Get user doc stream
 Stream<UserData> get userData {
   return reportCollection.document(uid).snapshots()
   .map(_userDataFromSnapshot);
 }

}