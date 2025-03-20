import 'package:flutter/material.dart';
import 'package:whatsapp_live_caption/services/overlay.dart';
import 'package:whatsapp_live_caption/services/translation.dart';
import 'package:whatsapp_live_caption/services/speech.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SpeechService _speechService = SpeechService();
  final TranslationService _translationService = TranslationService();
  bool isListening = false;
  String transcribedText = ""; // Store transcribed text
  String translatedText = ""; // Store translated text
  String selectedLanguage = "hi"; // Default language
  bool isMalicious = false; // Track if malicious content is detected

  final Map<String, String> languages = {
    "English": "en",
    "Hindi": "hi",
    "Punjabi": "pa",
    "Bengali": "bn"
  };

  final List<String> maliciousPhrases = [
    "digital arrest",
    "digital Aarrest",
    "digital assist",
    "digital rest",
    "Police aapke gate pe hai",
    "your bank account is blocked",
    "urgent action required",
    "urgent action",
    "police ghar aa rahi hai",
  ];

  Future<void> startTranslation() async {
    try {
      bool available = await _speechService.initialize();
      if (!available) {
        print("Speech recognition is not available.");
        return;
      }

      setState(() {
        isListening = true;
      });

      _speechService.startListening((text) async {
        bool containsMalicious = maliciousPhrases.any((phrase) => text.toLowerCase().contains(phrase.toLowerCase()));

        setState(() {
          transcribedText = text; // Update transcribed text on UI
          isMalicious = containsMalicious;
        });

        String alertMessage = isMalicious ? "⚠️ Malicious Content Detected!" : "✅ Safe Content";

        try {
          String translated = await _translationService.translateText(text, selectedLanguage);
          setState(() {
            translatedText = translated; // Update translated text on UI
          });

          OverlayService.showCustomOverlay("🎙 $text \n🌍 $translated \n$alertMessage");
        } catch (e) {
          print("Error in translation: $e");
        }
      });
    } catch (e) {
      print("Error initializing speech: $e");
    }
  }

  void stopTranslation() {
    _speechService.stopListening();
    setState(() {
      isListening = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://imgs.search.brave.com/sfqVZvAxc_0V_vB1v-l7ljQaMeuWC5k1RRnVF_kbgc8/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzJkL2Zl/LzZjLzJkZmU2Yzk2/ZThjODFhNjkwZGQ1/NDczNDE0MjY1ZDlk/LmpwZw'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(title: Text("Live Speech Transcription")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Select Language:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: selectedLanguage,
                onChanged: (newValue) {
                  setState(() {
                    selectedLanguage = newValue!;
                  });
                },
                items: languages.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.value,
                    child: Text(entry.key),
                  );
                }).toList(),
              ),

              SizedBox(height: 20),
              Text(
                "Transcribed Speech:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 5, bottom: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: isMalicious ? Colors.red : Colors.blue),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  transcribedText,
                  style: TextStyle(
                    fontSize: 16,
                    color: isMalicious ? Colors.red : Colors.black, // Highlight malicious text in red
                  ),
                ),
              ),

              if (isMalicious) // Show warning message if malicious content detected
                Text(
                  "⚠️ Malicious Speech Detected!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                ),

              SizedBox(height: 10),
              Text(
                "Translated Speech:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 5, bottom: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  translatedText,
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),
              ),

              ElevatedButton(
                onPressed: isListening ? stopTranslation : startTranslation,
                child: Text(isListening ? "Stop" : "Start"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
