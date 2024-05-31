import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:file_picker/_internal/file_picker_web.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/providers/user_provider.dart';
import 'package:flutter_new/services/common_service.dart';
import 'package:flutter_new/services/download_helper.dart';
import 'package:flutter_new/services/subject_service.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  final String? department;
  final String? semester;
  final String? subject;
  NotesPage({super.key, this.department, this.semester, this.subject});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  var userInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userInfo = Provider.of<UserProvider>(context, listen: false).getUserInfo;
    getNotes();
  }

  List notes = [];
  getNotes() async {
    var response = await SubjectService()
        .getNotes(widget.department, widget.semester, widget.subject);
    setState(() {
      notes = response['result'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          userInfo['userRole'].toString().toLowerCase() == "teacher"
              ? IconButton(
                  onPressed: () {
                    _uploadFile();
                  },
                  icon: Icon(Icons.note_add),
                  color: Colors.white,
                  iconSize: 30,
                )
              : SizedBox()
        ],
        backgroundColor: Color(0xffbe74ff),
        title: Text('Notes'),
      ),
      body: _status == 'Uploading...'
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator(), Text('Uploading...')],
              ),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    splashColor: Color.fromARGB(255, 250, 139, 131),
                    onLongPress: () {
                      if (userInfo['userRole'].toString().toLowerCase() ==
                          "teacher") {
                        deleteNote(getFileNameFromUrl(notes[index]));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 212, 162, 255),
                          borderRadius: BorderRadius.circular(5)),
                      child: ListTile(
                        title: Text(getFileNameFromUrl(notes[index])),
                        // trailing: Icon(Icons.delete_forever),
                        leading: GestureDetector(
                            onTap: () {
                              DownloadHelper().downloadFile(notes[index]);
                            },
                            child: Icon(Icons.download)),
                      ),
                    ),
                  ),
                );
              },
            ),
    ));
  }

  String _status = 'No file selected';
  Future<void> _uploadFile() async {
    FilePickerResult? result = null;
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    // if (kIsWeb) {
    //   result = await FilePickerWeb.platform.pickFiles(
    //     type: FileType.custom,
    //     allowedExtensions: ['pdf'],
    //   );
    // } else {
    //   result = await FilePicker.platform.pickFiles(
    //     type: FileType.custom,
    //     allowedExtensions: ['pdf'],
    //   );
    // }

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        _status = 'Uploading...';
      });

      FormData formData = FormData.fromMap({});
      print(widget.department);
      if (kIsWeb) {
        formData = FormData.fromMap({
          'file':
              await MultipartFile.fromBytes(file.bytes!, filename: file.name),
          'department': widget.department,
          'semester': widget.semester,
          'subject': widget.subject,
        });
      } else {
        formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(file.path!, filename: file.name),
          'department': widget.department,
          'semester': widget.semester,
          'subject': widget.subject,
        });
      }

      try {
        var response = await SubjectService().uploadNote(formData);
        if (response['statusCode'] == 200) {
          getNotes();
          setState(() {
            _status = 'File uploaded successfully';
          });
        } else {
          setState(() {
            _status = 'Failed to upload file';
          });
        }
      } catch (e) {
        setState(() {
          _status = 'Failed to upload file: $e';
        });
      }
    } else {
      setState(() {
        _status = 'No file selected';
      });
    }
  }

  deleteNote(filename) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: Color(0xffbe74ff),
              title: Text('Delete Note'),
              content: Text('Are you sure you want to delete?'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel')),
                ElevatedButton(
                    onPressed: () async {
                      var response = await SubjectService().deleteNote(
                          widget.department,
                          widget.semester,
                          widget.subject,
                          filename);
                      bool success = CommonService()
                          .handleResponseMessage(context, response);
                      if (success) {
                        getNotes();
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Delete'))
              ],
            ));
  }

  String getFileNameFromUrl(String url) {
    Uri uri = Uri.parse(url);
    String fileName = uri.pathSegments.last;
    return fileName;
  }
}
