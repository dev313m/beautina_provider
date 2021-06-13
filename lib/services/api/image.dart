import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

///Upload file server
final url = 'https://resorthome.000webhostapp.com/image.php';
// File file;

///Picking an image from device and returning the file as [file]
Future<File> imageChoose() async {
  return await ImagePicker.pickImage(source: ImageSource.gallery);
// file = await ImagePicker.pickImage(source: ImageSource.gallery);
}

///Take Image file and Image name then upload it, true if success, false else
Future<bool> imageUpload(File file, String name,
    {Function onSuccess, Function onError}) async {
  if (file == null) return false;
  String base64Image = base64Encode(file.readAsBytesSync());
  String ext = file.path.split(".").last;

  var task =
      FirebaseStorage.instance.ref().child('image_profile/$name').putFile(file);
  try {
    var s = await task;
    if (s.state == TaskState.success) return true;
  } catch (e) {
    return false;
  }
  // http.Response response = await http.post(url, body: {
  //   "image": base64Image,
  //   "fileName": name + '.' + ext,
  // });

  // if (response.statusCode == 200) return true;
  return false;
}
