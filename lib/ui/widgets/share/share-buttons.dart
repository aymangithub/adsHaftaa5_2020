import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';

class SystemShareButton extends StatelessWidget {
  String message;
  SystemShareButton(this.message);
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          final RenderBox box = context.findRenderObject();
          Share.share('إعلان أعجبني على الهفتاء',
              subject: this.message,
              sharePositionOrigin:
              box.localToGlobal(Offset.zero) &
              box.size);

        },
        icon: Icon(
          Icons.share,
          color: Colors.blueGrey,
        ));
  }
}

class WhatsappShareButton extends StatelessWidget {
  String message;
  WhatsappShareButton(this.message);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset("assets/icon/whatsapp.png"),
      onPressed: () {
        final RenderBox box = context.findRenderObject();
        Share.share('إعلان أعجبني على الهفتاء',
            subject: this.message,
            sharePositionOrigin:
            box.localToGlobal(Offset.zero) &
            box.size);      },
    );
  }
}
