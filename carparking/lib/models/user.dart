class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String vehicleId;
  final String desc;

  UserData({this.uid, this.vehicleId, this.desc});
}

class UserViolationData {
  final String uid;
  final String vehicle_no;
  final String parking_lot_id;
  final String slot_id;
  final String time;
  final String date;

  UserViolationData({this.uid, this.vehicle_no, this.parking_lot_id, this.slot_id, this.time, this.date});
}

class UserTicketData {
  final String uid;
  final String vehicle_no;
  final String reason;

  UserTicketData({this.uid, this.vehicle_no, this.reason});
}