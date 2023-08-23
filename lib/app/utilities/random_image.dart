import 'dart:math';

class RandomImage {
  static String randomPickUrl() {
    final randomInt = Random().nextInt(2000);
    return "https://picsum.photos/seed/$randomInt/200/300";
  }
}
