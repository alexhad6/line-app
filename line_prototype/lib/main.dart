import 'package:line_prototype/userInterface.dart';
import 'package:line_prototype/database.dart';

/// Called when the app starts.
void main() {
  final userInterface = UserInterface();
  final database = Database();
  userInterface.start();
}
