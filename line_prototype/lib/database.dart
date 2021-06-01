import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Database._();

  static final Database instance = Database._();
  late final CollectionReference _lines;

  void initialize() {
    _lines = FirebaseFirestore.instance.collection('lines');
  }

  Future<void> addLine({
    required String address,
    required int waitTime,
  }) async {
    try {
      await _lines.add({
        'address': address,
        'time': waitTime,
      });
      print('Line added');
    } catch (e) {
      print('Error $e');
    }
  }
}
