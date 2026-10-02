import 'package:uuid/uuid.dart';

class IdUtils {
  static const Uuid _uuid = Uuid();

  static String get v4id => _uuid.v4();
}
