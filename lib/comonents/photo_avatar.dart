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
            content: Text('image url copied to Clipboard'),
            action: SnackBarAction(
              label: 'Dismiss',
              onPressed: () {},
            ),
          );
          scaffoldKey.currentState.showSnackBar(snackBar);
        });
      },
      child: Center(
        child: Container(
          width: 150.0,
          height: 150.0,
          padding: EdgeInsets.all(7.0), // border width
          decoration: BoxDecoration(
            color: Colors.white12, // border color
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black26,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
          child: CircleAvatar(
              foregroundColor: Colors.white70,
              backgroundColor: Colors.white70,
              radius: 50,
              backgroundImage: image.startsWith('http')
                  ? NetworkImage(image)
                  : AssetImage(image)),
        ),
      ),
    );
  }
}
