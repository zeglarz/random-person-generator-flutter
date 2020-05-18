import 'package:flutter/material.dart';

class PhotoAvatar extends StatelessWidget {
  PhotoAvatar(this.image);
  ImageProvider image;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 150.0,
        height: 150.0,
        padding: EdgeInsets.all(7.0), // border width
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF), // border color
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.white,
            radius: 50,
            backgroundImage: this.image),
      ),
    );
  }
}
