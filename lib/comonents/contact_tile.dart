import 'package:flutter/material.dart';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:skeleton_text/skeleton_text.dart';

class ContactTile extends StatelessWidget {
  const ContactTile(
      {@required this.scaffoldKey, this.content, this.icon, this.loading});
  final String content;
  final IconData icon;
  final bool loading;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FlutterClipboardManager.copyToClipBoard('$context').then((result) {
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
              color: Colors.white.withOpacity(0.8),
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: ListTile(
                leading: Icon(
                  this.icon,
                  color: Colors.white,
                ),
                title: Center(
                  child: Text(
                    '$content',
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.7),
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
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[300]),
                ),
              ),
            ),
    );
  }
}
