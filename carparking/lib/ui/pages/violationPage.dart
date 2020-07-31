import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:testing/ui/widgets/app_bar.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ViolationPage extends StatefulWidget {
  static const String route = '/violation_page';

  @override
  ViolationPageState createState() => ViolationPageState();
}

class ViolationPageState extends State<ViolationPage> {
  @override
  void initState() {
    super.initState();
  }

  DateTime selectedDate = DateTime.now();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  final _formKey = GlobalKey<FormState>();

  String vehicle_no;
  String parking_lot_id;
  String slot_id;
  String image;
  String time;
  String date;

  /// Active image file
  File _imageFile;

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  /// Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
        toolbarTitle: 'Crop It');

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationBar(),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Report Violation',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Report unauthorized parking here',
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter vehicle number',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Vehicle number cannot be empty';
                      }
                      _formKey.currentState.save();
                      return null;
                    },
                    onSaved: (value) => vehicle_no = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter parking lot ID',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Parking lot ID cannot be empty';
                      }
                      _formKey.currentState.save();
                      return null;
                    },
                    onSaved: (value) => vehicle_no = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter slot ID',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Slot ID cannot be empty';
                      }
                      _formKey.currentState.save();
                      return null;
                    },
                    onSaved: (value) => vehicle_no = value,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () async {
                          final selectedDate = await _selectDateTime(context);
                          if (selectedDate == null) return;
                          print(selectedDate);

                          final selectedTime = await _selectTime(context);
                          if (selectedDate == null) return;
                          print(selectedTime);

                          setState(() {
                            this.selectedDate = DateTime(
                              selectedDate.year,
                              selectedDate.month,
                              selectedDate.day,
                              selectedTime.hour,
                              selectedTime.minute,
                            );
                          });
                        },
                        child: Text(
                          'Choose Date and Time',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Text(
                        dateFormat.format(selectedDate),
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Choose image',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      IconButton(
                        icon: Icon(Icons.photo_camera),
                        onPressed: () => _pickImage(ImageSource.camera),
                        color: Colors.grey[400],
                      ),
                      IconButton(
                        icon: Icon(Icons.photo_library),
                        onPressed: () => _pickImage(ImageSource.gallery),
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
                if (_imageFile != null) ...[
                  Image.file(_imageFile),
                  Row(
                    children: <Widget>[
                      FlatButton(
                        child: Icon(Icons.crop),
                        onPressed: _cropImage,
                      ),
                      FlatButton(
                        child: Icon(Icons.refresh),
                        onPressed: _clear,
                      ),
                    ],
                  ),
                  Uploader(file: _imageFile)
                ],
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () => _clear,
                        child: Text(
                          'Report',
                          style: TextStyle(fontSize: 18),
                        ),
                        color: Colors.lightBlue,
                      ),
                      SizedBox(
                        width: 100.0,
                      ),
                      RaisedButton(
                        onPressed: () {},
                        child: Text(
                          'Clear',
                          style: TextStyle(fontSize: 18),
                        ),
                        color: Colors.red,
                      ),
                    ],
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

Future<DateTime> _selectDateTime(BuildContext context) => showDatePicker(
    context: context,
    initialDate: DateTime.now().add(Duration(seconds: 1)),
    firstDate: DateTime(2020),
    lastDate: DateTime(2023));

Future<TimeOfDay> _selectTime(BuildContext context) {
  final now = DateTime.now();

  return showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
  );
}

class Uploader extends StatefulWidget {
  final File file;
  Uploader({Key key, this.file}) : super(key: key);

  createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://campus-parking-28bb8.appspot.com/');
  StorageUploadTask _uploadTask;

  void _startUpload() {
    String filePath = 'images/${DateTime.now()}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (context, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(
              children: [
                if (_uploadTask.isComplete) Text('Upload Successful!'),
                if (_uploadTask.isPaused)
                  FlatButton(
                    child: Icon(Icons.play_arrow),
                    onPressed: _uploadTask.resume,
                  ),
                if (_uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(Icons.pause),
                    onPressed: _uploadTask.pause,
                  ),
                LinearProgressIndicator(value: progressPercent),
                Text('${(progressPercent * 100).toStringAsFixed(2)} % '),
              ],
            );
          });
    } else {
      return FlatButton.icon(
        label: Text('Upload to Firebase'),
        color: Colors.blue,
        icon: Icon(Icons.cloud_upload),
        onPressed: _startUpload,
      );
    }
  }
}

// class ApplicationBar extends StatelessWidget implements PreferredSizeWidget {
//   AppBar appBarWidget = AppBar(
//     title: Row(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//           child: Container(
//             height: 35.0,
//             width: 35.0,
//             child: CircleAvatar(
//               radius: 50,
//               backgroundImage: AssetImage('assets/nwmsu_logo.png'),
//             ),
//           ),
//         ),
//         Text("Campus Parking"),
//       ],
//     ),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return appBarWidget;
//   }

//   @override
//   Size get preferredSize {
//     return appBarWidget.preferredSize;
//   }
// }