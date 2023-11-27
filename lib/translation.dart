import 'package:bfmh_canteen/translation/bangla.dart';
import 'package:bfmh_canteen/translation/eng.dart';
import 'package:get/get.dart';

class Translation extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_US': eng,
        'bn_BD': ban,
      };
}
