import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing/models/report.dart';
import 'package:testing/models/user.dart';
import 'package:testing/models/violation.dart';

class DatabaseService {

final String uid;
DatabaseService({this.uid});

// Collection reference
final CollectionReference reportCollection = Firestore.instance.collection('reports');
final CollectionReference violationColection = Firestore.instance.collection('violations');

// Update function for reports
Future updateUserData(String vehicleId, String desc) async {
  return await reportCollection.document(uid).setData({
    'Vehicle ID': vehicleId,
    'Description': desc,
  });
}

// Update function for violations
Future updateUserViolationData(String vehicle_no, String parking_lot_id, String slot_id, String time, String date) async {
  return await violationColection.document(uid).setData({
    'Vehicle Number': vehicle_no,
    'Parking Lot ID': parking_lot_id,
    'Slot ID': slot_id,
    'Time': time,
    'Date': date,
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

// Violation list from snapshot
List<Violation> _violationListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.documents.map((doc){
    return Violation(
      vehicle_no: doc.data['Vehicle Number'] ?? '',
      parking_lot_id: doc.data['Parking Lot ID'] ?? '',
      slot_id: doc.data['Slot ID'] ?? '',
      time: doc.data['Time'] ?? '',
      date: doc.data['Date'] ?? '',
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

// Violation userData from snapshot
UserViolationData _userViolationDataFromSnapshot(DocumentSnapshot snapshot) {
   return UserViolationData(
     uid: uid,
     vehicle_no: snapshot.data['Vehicle Number'],
     parking_lot_id: snapshot.data['Parking Lot ID'],
     slot_id: snapshot.data['Slot ID'],
     time: snapshot.data['Time'],
     date: snapshot.data['Date'],
   );
 }

 // Get records stream
 Stream<List<Report>> get reports {
   return reportCollection.snapshots()
   .map(_reportListFromSnapshot);
 }

 // Get violations stream
 Stream<List<Violation>> get violations {
   return violationColection.snapshots()
   .map(_violationListFromSnapshot);
 }

 // Get user doc stream
 Stream<UserData> get userData {
   return reportCollection.document(uid).snapshots()
   .map(_userDataFromSnapshot);
 }

 // Get user doc streams for violations
 Stream<UserViolationData> get userViolationData {
   return reportCollection.document(uid).snapshots()
   .map(_userViolationDataFromSnapshot);
 }

}