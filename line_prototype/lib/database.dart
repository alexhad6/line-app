import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Database._();

  static final Database instance = Database._();
  late final CollectionReference _lines;

  void initialize() {
    _lines = FirebaseFirestore.instance.collection('lines');
  }

  Future<void> addLine({
    required String lineName,
    required List<String> people,
    required int waitTime,
  }) async {
    final data = <String, Object>{
      'lineName': lineName,
      'people': people,
      'waitTime': waitTime,
    };

    try {
      await _lines.add(data);
      print('Line added');
    } catch (e) {
      print('Error $e');
    }
  }
}
