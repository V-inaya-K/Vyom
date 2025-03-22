import 'package:flutter/material.dart';
import 'package:whatsapp_live_caption/Authentication/signup.dart';
import 'package:whatsapp_live_caption/services/overlay.dart';
import 'package:whatsapp_live_caption/services/translation.dart';
import 'package:whatsapp_live_caption/services/speech.dart';
import 'package:google_fonts/google_fonts.dart';
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
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Color.fromARGB(197, 52, 146, 241), // Change as needed
        title: Text(
          "Vyom - One and Only Digital Arrest Detector",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          )
        ),
        actions: [
          IconButton(
            onPressed: () => _showPopup(context, ChatbotPopup()),
            color: Colors.white,
            icon: Icon(Icons.message),
          ),
          IconButton(
            onPressed: () => _showPopup(context, NotificationsPopup()),
            color: Colors.white,
            icon: Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () => _showPopup(context, ProfilePopup()),
            color: Colors.white,
            icon: Icon(Icons.account_circle_rounded),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            icon: Icon(Icons.logout),
            color: Colors.white,
          ),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage('https://imgs.search.brave.com/0PPZHtca9KhsDYyYmI4n_BqcIERNo4WgEuZm0sI2tkA/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/dmVjdG9yc3RvY2su/Y29tL2kvcHJldmll/dy0xeC85MS8xMS9w/YXN0ZWwtYmFja2dy/b3VuZC12ZWN0b3It/MjAxOTExMS5qcGc'),
                fit: BoxFit.cover)
        ),
        child: Container(
            margin: EdgeInsets.only(left: 40, right: 40),
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "home.png",
                      width: 400,
                      height: 200,
                    ),

                    Text(
                      "Select Language:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5,),
                    SizedBox(
                      width: 100,
                      height: 30,
                      child: Container(
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          color: Colors.white, // Background color
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: DropdownButton<String>(
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
                      ),
                    ),

                    SizedBox(height: 20),
                    Text(
                      "Transcribed Speech:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 5, bottom: 20),
                      decoration: BoxDecoration(
                        color:isMalicious ? Colors.grey[300] :Colors.grey[100],
                        border: Border.all(color: isMalicious ? Colors.red : Colors.green),
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

                    if(isMalicious) // Show warning message if malicious content detected
                      Text(
                        "⚠️ Malicious Speech Detected!",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                      )else(
                    Text("Recognizing...",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent,)
                    )),

                    SizedBox(height: 10),
                    Text(
                      "Translated Speech:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 5, bottom: 20),
                      decoration: BoxDecoration(
                        color: isListening ? Colors.grey[200] :Colors.grey[100],
                        border: Border.all(color: isListening ? Colors.blue : Colors.green),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                          translatedText,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),

                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                          ),
                          onPressed: isListening ? stopTranslation : startTranslation,
                          child: Text(isListening ? "Stop" : "Start",
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                color: Colors.white
                              ),),
                          ),
                        ),

                  ],
                ),
              ),
          ),
      ),


    );
  }
}

void _showPopup(BuildContext context, Widget popup) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: popup,
      );
    },
  );
}
class ChatbotPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Text("Chatbot Content"),
    );
  }
}

class NotificationsPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Text("Notifications Content"),
    );
  }
}

class ProfilePopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Text("Profile Content"),
    );
  }
}
// ------------------------------------
// Firebase Edition
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatelessWidget {
//   final User user;
//   HomeScreen({required this.user});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Home Page")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Welcome, ${user.email ?? user.phoneNumber}"),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 await FirebaseAuth.instance.signOut();
//                 Navigator.pop(context);
//               },
//               child: Text("Logout"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
