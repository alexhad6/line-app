import 'package:firebase_core/firebase_core.dart';

import 'package:line_prototype/userInterface.dart';
import 'package:line_prototype/database.dart';

final database = Database.instance;
final userInterface = UserInterface.instance;

/// Called when the app starts.
void main() {
  userInterface.start(() async {
    await Firebase.initializeApp();
    database.initialize();
  });
}
