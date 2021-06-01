import 'package:line_prototype/userInterface.dart';
import 'package:line_prototype/database.dart';
import 'package:firebase_core/firebase_core.dart';

final database = Database.instance;
final userInterface = UserInterface.instance;

/// Called when the app starts.
void main() {
  userInterface.start(() async {
    await Firebase.initializeApp();
    database.initialize();
    ready();
  });
}

Future<void> ready() async {
  await database.addLine(
    address: 'Highland Circle',
    waitTime: 15,
  );
}
