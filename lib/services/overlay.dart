// import 'package:flutter/material.dart';
// import 'package:flutter_overlay_window/flutter_overlay_window.dart';
//
// class OverlayService {
//   static void showCustomOverlay(String subtitle) {
//     FlutterOverlayWindow.showOverlay(
//       height: 100,
//       width: double.infinity.toInt(),
//       overlayWidget: OverlayWidget(subtitle: subtitle),
//     );
//   }
// }
//
// class OverlayWidget extends StatelessWidget {
//   final String subtitle;
//   OverlayWidget({required this.subtitle});
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: Container(
//         color: Colors.black54,
//         padding: EdgeInsets.all(10),
//         child: Text(
//           subtitle,
//           style: TextStyle(color: Colors.white, fontSize: 18),
//         ),
//       ),
//     );
//   }
// }
// ------------------------------------
// import 'package:flutter/material.dart';
// import 'package:flutter_overlay_window/flutter_overlay_window.dart';
//
// class OverlayService {
//   static Future<void> showCustomOverlay(String subtitle) async {
//     await FlutterOverlayWindow.showOverlay(
//       height: 100,
//       width: 300, // Set a fixed width, double.infinity is not allowed
//       enableDrag: true,
//       overlayTitle: "Live Caption",
//       overlayContent: subtitle,
//       flag: OverlayFlag.defaultFlag,
//       alignment: OverlayAlignment.center,
//       visibility: NotificationVisibility.visibilityPublic,
//     );
//   }
// }
// ----------------------------------
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class OverlayService {
  static Future<void> showCustomOverlay(String text) async {
    await FlutterOverlayWindow.showOverlay(
      height: 120,
      width: 300,
      enableDrag: true,
      overlayTitle: "Live Speech",
      overlayContent: text, // Now displays both transcribed & translated text
      flag: OverlayFlag.defaultFlag,
      alignment: OverlayAlignment.center,
      visibility: NotificationVisibility.visibilityPublic,
    );
  }
}
