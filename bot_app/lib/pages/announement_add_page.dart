import 'dart:io';
import 'dart:math';
// import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/project/routes/app_route_constants.dart';
import 'package:flutter_new/providers/announcement_provider.dart';
import 'package:flutter_new/providers/user_provider.dart';
import 'package:flutter_new/services/subject_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class AnnouncementAddPage extends StatefulWidget {
  const AnnouncementAddPage({super.key});

  @override
  State<AnnouncementAddPage> createState() => _AnnouncementAddPageState();
}

class _AnnouncementAddPageState extends State<AnnouncementAddPage> {
  EditableItem imageConf = EditableItem();
  EditableItem textConf = EditableItem();

  late Offset _initPos;

  late Offset _currentPos;

  late double _currentScale;

  late double _currentRotation;

  bool _inAction = false;

  List<EditableItem> storyWidgets = [];

  final _key = GlobalKey();
  WidgetsToImageController widgetsToImageController =
      WidgetsToImageController();
  bool isLoading = false;
  saveAnnouncement() async {
    if (storyWidgets.isEmpty) return;
    setState(() {
      isLoading = true;
    });
    var uuid = Uuid();
    var uid_v1 = uuid.v1();
    var userInfo =
        Provider.of<UserProvider>(context, listen: false).getUserInfo;
    final bytes = await widgetsToImageController.capture();
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromBytes(bytes!,
          filename: "announcement-${uid_v1}"),
      'userName': userInfo['userName'],
      'userId': userInfo['id']
    });
    try {
      var response = await SubjectService().uploadAnnouncement(formData);
      if (response['statusCode'] == 200) {
        AnnouncementProvider provider =
            Provider.of<AnnouncementProvider>(context, listen: false);
        provider.addAnnouncement(response['result'][0]);
        GoRouter.of(context).pop(context);
      } else {}
      setState(() {
        isLoading = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    // final size = _key.currentContext?.size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Announcement", style: TextStyle(fontSize: 25)),
        backgroundColor: const Color(0xffbe74ff),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () {
                  saveAnnouncement();
                },
                child: Text(
                  'Done',
                  style: TextStyle(fontSize: 20),
                )),
          )
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GestureDetector(
              onScaleStart: (details) {
                if (imageConf == null) return;

                _initPos = details.focalPoint;
                _currentPos = imageConf.position;
                _currentScale = imageConf.scale;
                _currentRotation = imageConf.rotation;
              },
              onScaleUpdate: (details) {
                if (imageConf == null) return;
                final delta = details.focalPoint - _initPos;
                final left = (delta.dx / screen.width) + _currentPos.dx;
                final top = (delta.dy / screen.height) + _currentPos.dy;

                setState(() {
                  imageConf.position = Offset(left, top);
                  imageConf.rotation = details.rotation + _currentRotation;
                  imageConf.scale =
                      max(min(details.scale * _currentScale, 3), 0.2);
                });
              },
              child: WidgetsToImage(
                controller: widgetsToImageController,
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: [...storyWidgets.map(_buildItemWidget).toList()],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.photo), label: "Image"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.textbox), label: "Text"),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffb152e8),
        onPressed: () {
          if (_selectedIndex == 1) {
            showTextCreator();
          } else {
            openFilePicker();
          }
        },
        child: Icon(
          CupertinoIcons.plus,
          color: Colors.white,
        ),
      ),
    );
  }

  var _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  openFilePicker() async {
    FilePickerResult? result = null;
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpeg', 'jpg'],
    );

    // if (kIsWeb) {
    //   result = await FilePickerWeb.platform.pickFiles(
    //     type: FileType.custom,
    //     allowedExtensions: ['png', 'jpeg', 'jpg'],
    //   );
    // } else {
    //   result = await FilePicker.platform.pickFiles(
    //     type: FileType.custom,
    //     allowedExtensions: ['png', 'jpeg', 'jpg'],
    //   );
    // }
    if (result != null) {
      PlatformFile file = result.files.first;
      var newItem = EditableItem();
      newItem.type = ItemType.Image;
      newItem.value = file.path;
      newItem.index = storyWidgets.length + 1;
      setState(() {
        storyWidgets.add(newItem);
      });
    }
  }

  TextEditingController textController = TextEditingController();
  Color textColor = Colors.red;
  double _currentSliderValue = 20;
  showTextCreator() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState2) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                    TextField(
                      maxLines: 5,
                      controller: textController,
                      decoration:
                          InputDecoration(hintText: 'Type something...'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                // Store current color before we open the dialog.
                                final Color colorBeforeDialog = textColor;
                                // Wait for the picker to close, if dialog was dismissed,
                                // then restore the color we had before it was opened.
                                if (!(await colorPickerDialog(setState2))) {
                                  setState(() {
                                    textColor = colorBeforeDialog;
                                  });
                                }
                              },
                              icon: Icon(
                                CupertinoIcons.color_filter,
                                color: textColor,
                              )),
                          Slider(
                            value: _currentSliderValue,
                            max: 100,
                            divisions: 10,
                            label: _currentSliderValue.round().toString(),
                            onChanged: (double value) {
                              setState2(() {
                                _currentSliderValue = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    IconButton.outlined(
                        onPressed: () {
                          var newItem = EditableItem();
                          newItem.type = ItemType.Text;
                          newItem.value = textController.text;
                          newItem.textColor = textColor;
                          newItem.fontSize = _currentSliderValue;
                          newItem.index = storyWidgets.length + 1;
                          setState(() {
                            storyWidgets.add(newItem);
                          });
                          textController.clear();
                          print(storyWidgets[0].value);
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.done))
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  TextEditingController editTextController = TextEditingController();
  showTextEditor(EditableItem e) {
    print(e.value!);
    editTextController.text = e.value!;
    textColor = e.textColor!;
    _currentSliderValue = e.fontSize!;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState2) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  storyWidgets
                                      .removeWhere((i) => i.index == e.index);
                                });
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.delete)),
                        )
                      ],
                    ),
                    TextField(
                      maxLines: 5,
                      controller: editTextController,
                      decoration:
                          InputDecoration(hintText: 'Type something...'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                // Store current color before we open the dialog.
                                final Color colorBeforeDialog = textColor;
                                // Wait for the picker to close, if dialog was dismissed,
                                // then restore the color we had before it was opened.
                                if (!(await colorPickerDialog(setState2))) {
                                  setState(() {
                                    textColor = colorBeforeDialog;
                                  });
                                }
                              },
                              icon: Icon(
                                CupertinoIcons.color_filter,
                                color: e.textColor,
                              )),
                          Slider(
                            value: e.fontSize!,
                            max: 100,
                            divisions: 10,
                            label: _currentSliderValue.round().toString(),
                            onChanged: (double value) {
                              setState2(() {
                                e.fontSize = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    IconButton.outlined(
                        onPressed: () {
                          int indexToEdit = storyWidgets.indexOf(e);
                          print(indexToEdit);
                          // var newItem = EditableItem();
                          // newItem.type = ItemType.Text;
                          // newItem.value = textController.text;
                          // newItem.textColor = textColor;
                          // newItem.fontSize = _currentSliderValue;
                          // newItem.index = e.index;
                          setState(() {
                            // e.textColor = textColor;
                            e.value = editTextController.text;
                            e.textColor = textColor;
                            // storyWidgets[indexToEdit].textColor = textColor;
                            // storyWidgets[indexToEdit].fontSize = _currentSliderValue;
                            // storyWidgets[indexToEdit].value = textController.text;

                            // storyWidgets[indexToEdit].index = e.index;
                          });
                          print(storyWidgets[indexToEdit].value);
                          // textController.clear();
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.done))
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildItemWidget(EditableItem e) {
    final screen = MediaQuery.of(context).size;

    var widget;
    switch (e.type!) {
      case ItemType.Text:
        widget = GestureDetector(
          onDoubleTap: () {
            showTextEditor(e);
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            child: Text(
              e.value!,
              // maxLines: 5,
              // overflow: TextOverflow.ellipsis,
              style: TextStyle(color: e.textColor, fontSize: e.fontSize),
            ),
          ),
        );
        break;
      case ItemType.Image:
        widget = GestureDetector(
            onDoubleTap: () {
              openDeleteImageDialog(e);
            },
            child: Image.file(File(e.value!)));
    }

    return Positioned(
      top: e.position.dy * screen.height,
      left: e.position.dx * screen.width,
      child: Transform.scale(
        scale: e.scale,
        child: Transform.rotate(
          angle: e.rotation,
          child: Listener(
            onPointerDown: (details) {
              if (_inAction) return;
              _inAction = true;
              imageConf = e;
              _initPos = details.position;
              _currentPos = e.position;
              _currentScale = e.scale;
              _currentRotation = e.rotation;
            },
            onPointerUp: (details) {
              _inAction = false;
            },
            child: widget,
          ),
        ),
      ),
    );
  }

  Future<bool> colorPickerDialog(Function setState) async {
    return ColorPicker(
      color: textColor,
      onColorChanged: (Color color) {
        setState(() {
          textColor = color;
        });
      },
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodyMedium,
      colorCodePrefixStyle: Theme.of(context).textTheme.bodySmall,
      selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      // customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      actionsPadding: const EdgeInsets.all(16),
      constraints:
          const BoxConstraints(minHeight: 480, minWidth: 300, maxWidth: 320),
    );
  }

  openDeleteImageDialog(EditableItem e) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Remove Image"),
          content: Text('Are you sure you want to remove this image?'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    storyWidgets
                        .removeWhere((element) => element.index == e.index);
                  });
                  Navigator.pop(context);
                },
                child: Text('Remove'))
          ],
        );
      },
    );
  }
}

enum ItemType { Image, Text }

class EditableItem {
  Offset position = Offset(0.1, 0.1);
  double scale = 1.0;
  double rotation = 0.0;
  ItemType? type;
  String? value;
  Color? textColor;
  double? fontSize;
  int? index;
}

final mockData = [
  EditableItem()
    ..type = ItemType.Text
    ..value = 'Hello',
  EditableItem()
    ..type = ItemType.Text
    ..value = 'World',
  EditableItem()
    ..type = ItemType.Image
    ..value = 'assets/6062794.jpg',
];
