import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:testing/shared/loading.dart';
import 'package:testing/ui/pages/user_home_page.dart';
import 'package:testing/ui/widgets/app_bar.dart';
import 'package:testing/models/user.dart';
import 'package:testing/services/database.dart';

class ticket extends StatefulWidget {
  static const String route = '/ticket';

  @override
  _ticketState createState() => _ticketState();
}

class _ticketState extends State<ticket> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String vehicle_no = '';
  String reason = '';

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
        toolbarColor: Colors.deepPurpleAccent[400],
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
    final user = Provider.of<User>(context);

    return StreamBuilder<UserTicketData>(
        stream: DatabaseService(uid: user.uid).userTicketData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserTicketData userTicketData = snapshot.data;

    return loading
        ? Loading()
        : Scaffold(
            appBar: ApplicationBar(),
            body: Form(
                key: _formKey,
                child: SafeArea(
                  child: ListView(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Tickets',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 30),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Raise or drop a ticket',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Vehicle Number',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Vehicle number cannot be empty';
                            }
                            _formKey.currentState.save();
                            return null;
                          },
                          onChanged: (value) =>
                              setState(() => vehicle_no = value),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Reason for ticket',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Parking lot ID cannot be empty';
                            }
                            _formKey.currentState.save();
                            return null;
                          },
                          onChanged: (value) =>
                              setState(() => reason = value),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Choose Image',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    ButtonTheme(
                                      minWidth: 150.0,
                                      height: 45.0,
                                      child: RaisedButton(
                                        onPressed: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            setState(() => loading = true);
                                            await DatabaseService(uid: user.uid)
                                                .updateUserTicketData(
                                              vehicle_no ??
                                                  userTicketData.vehicle_no,
                                              reason ??
                                                  userTicketData
                                                      .reason,
                                            );
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    UserHomePage.route);
                                          }
                                        },
                                        color: Colors.lightBlue,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side:
                                                BorderSide(color: Colors.grey)),
                                        splashColor: Colors.blue,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.report,
                                              size: 30.0,
                                              color: Colors.grey[300],
                                            ),
                                            Text(
                                              'Raise/Drop',
                                              style: TextStyle(
                                              fontSize: 20.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    ButtonTheme(
                                      minWidth: 150.0,
                                      height: 45.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  UserHomePage.route);
                                        },
                                        color: Colors.red,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side:
                                                BorderSide(color: Colors.grey)),
                                        splashColor: Colors.red,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.clear,
                                              size: 30.0,
                                              color: Colors.grey[300],
                                            ),
                                            Text('Cancel',
                                                style:
                                                    TextStyle(fontSize: 20.0)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                    ],
                  ),
                )));
          }
                else {
                  return Loading();
                }
          });
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
    String filePath = 'imagesTickets/${DateTime.now()}.png';

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
        label: Text('Upload Image'),
        color: Colors.teal[500],
        icon: Icon(Icons.cloud_upload),
        onPressed: _startUpload,
      );
    }
  }
}

// @override
// Widget buildButton(
//     String buttonText, double buttonHeight, Color buttonColor) {
//   return Container(
//     // height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
//     color: buttonColor,
//     child: FlatButton(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(0.0),
//             side: BorderSide(
//                 color: Colors.white, width: 2, style: BorderStyle.solid)),
//         padding: EdgeInsets.all(16.0),
//         //onPressed: () => buttonPressed(buttonText),
//         child: Text(
//           buttonText,
//           style: TextStyle(
//               fontSize: 30.0,
//               fontWeight: FontWeight.normal,
//               color: Colors.white),
//         )),
//   );
// }
