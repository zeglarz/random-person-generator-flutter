import 'package:flutter/material.dart';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:skeleton_text/skeleton_text.dart';

class ContactTile extends StatelessWidget {
  const ContactTile(
      {@required this.scaffoldKey,
      this.content,
      this.icon,
      this.loading,
      this.fontSize = 13.0});
  final String content;
  final IconData icon;
  final bool loading;
  final double fontSize;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FlutterClipboardManager.copyToClipBoard('$content').then((result) {
          final snackBar = SnackBar(
            content: Text('$content copied to Clipboard'),
            action: SnackBarAction(
              label: 'Dismiss',
              onPressed: () {},
            ),
          );
          scaffoldKey.currentState.showSnackBar(snackBar);
        });
      },
      child: !this.loading
          ? Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.grey.shade200.withOpacity(0.7),
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: ListTile(
                leading: Icon(
                  this.icon,
                  color: Colors.black38,
                ),
                title: Center(
                  child: Text(
                    '$content',
                    style: TextStyle(
                      fontSize: this.fontSize,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                      fontFamily: 'Source Sans Pro',
                    ),
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: SkeletonAnimation(
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.grey[300]),
                ),
              ),
            ),
    );
  }
}
