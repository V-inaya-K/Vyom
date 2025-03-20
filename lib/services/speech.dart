import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechService {
  final stt.SpeechToText _speech = stt.SpeechToText();

  Future<bool> initialize() async {
    return await _speech.initialize();
  }

  void startListening(Function(String) onSpeechResult) {
    _speech.listen(onResult: (result) {
      onSpeechResult(result.recognizedWords);
    });
  }

  void stopListening() {
    _speech.stop();
  }
}
