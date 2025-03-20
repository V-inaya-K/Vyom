import 'package:translator/translator.dart';

class TranslationService {
  final GoogleTranslator translator = GoogleTranslator();

  Future<String> translateText(String text, String targetLang) async {
    Translation translation = await translator.translate(text, to: targetLang);
    return translation.text;
  }
}
