import 'package:flutter/material.dart';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';

class PhotoAvatar extends StatelessWidget {
  PhotoAvatar(this.image, this.scaffoldKey);
  String image;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FlutterClipboardManager.copyToClipBoard('$image').then((result) {
          final snackBar = SnackBar(
            content: Text('Image URL copied to Clipboard'),
            action: SnackBarAction(
              label: 'Dismiss',
              onPressed: () {},
            ),
          );
          scaffoldKey.currentState.showSnackBar(snackBar);
        });
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Container(
          padding: EdgeInsets.all(1.0), // borde width
          decoration: BoxDecoration(
            color: Colors.black12, // border color
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 75,
            child: CircleAvatar(
                backgroundColor: Colors.white30,
                radius: 70,
                backgroundImage: image.startsWith('http')
                    ? NetworkImage(image)
                    : AssetImage(image)),
          ),
        ),
      ),
    );
  }
}
