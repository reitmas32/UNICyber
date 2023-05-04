// ignore: file_names
import 'dart:math';

String randomString() {
  final random = Random();
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  return String.fromCharCodes(
    Iterable.generate(
      10,
      (_) => chars.codeUnitAt(
        random.nextInt(chars.length),
      ),
    ),
  );
}
