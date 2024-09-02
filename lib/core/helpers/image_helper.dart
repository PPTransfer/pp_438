import 'dart:convert';
import 'dart:typed_data';

class ImageHelper {
   static String convertFileToBase64(Uint8List file)  {
    String img64 = base64Encode(file);

    return img64;
  }

  static Uint8List convertBase64ToFile(String base64Image)  {
    Uint8List bytes = base64.decode(base64Image);

    return bytes;
  }

}