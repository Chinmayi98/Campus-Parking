import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:testing/ui/pages/violationPage.dart';
import 'package:testing/ui/widgets/app_bar.dart';
import 'package:testing/services/database.dart';
import 'package:provider/provider.dart';
import 'package:testing/models/report.dart';
/// ignore: camel_case_types
class reportPage extends StatefulWidget {
  static const String route = '/report';

 @override
  _reportPageState createState() => _reportPageState();
}
// ignore: camel_case_types
class _reportPageState extends State<reportPage> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  String vehicle_no;
  String image;
  String description;

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
    return StreamProvider<List<Report>>.value(
          value: DatabaseService().reports,
          child: Scaffold(
          appBar: ApplicationBar(),

          // bottomNavigationBar: BottomAppBar(
          //   child: Row(
          //     children: <Widget>[
          //       IconButton(
          //         icon: Icon(Icons.photo_camera),
          //         onPressed: () => _pickImage(ImageSource.camera),
          //       ),
          //       IconButton(
          //         icon: Icon(Icons.photo_library),
          //         onPressed: () => _pickImage(ImageSource.gallery),
          //       ),
          //     ],
          //   ),
          // ),

          body: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Report',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Report any inconsistent data by entering the details below. Upload image from either gallery or camera',
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter description',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Description cannot be empty';
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (value) => description = value,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 0, 0),
                child: Row(
                  children: <Widget>[
                    Text(
                    'Choose image',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
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
                height: 75,
                margin: EdgeInsets.fromLTRB(90.0, 15.0, 0, 0),
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {},
                      child: Text(
                        'Report',
                        style: TextStyle(fontSize: 18),
                      ),
                      color: Colors.lightBlue,
                    ),
                    SizedBox(
                      width: 60.0,
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
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                    onPressed: () async=> Navigator.of(context)
                    .pushReplacementNamed(ViolationPage.route),
                    child: Text('Report unauthorized users',
                    )),
                  ],
                ),
              ),
            ],
          )),
    );
  }
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

