import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_video/service.dart';

void main() => runApp(new FilePickerDemo());

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _fileName;
  List<PlatformFile> _paths;
  String _directoryPath;
  String _extension;
  bool _loadingPath = false;
  TextEditingController _controller = TextEditingController();
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: false,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '')?.split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName = _paths != null ? _paths.map((e) => e.name).toString() : '...';
    });
  }

  List<String> _getFileInfo() {
    final bool isMultiPath = _paths != null && _paths.isNotEmpty;
    final String name = (isMultiPath
        ? _paths.map((e) => e.name).toList().first
        : _fileName ?? '...');
    final path = _paths.map((e) => e.path).toList().first.toString();
    return [name, path];
  }

  uploadFile(List<String> fileInfo) {
    _isUploading = true;
    UploadService.uploadVideoFile(fileInfo.first, fileInfo.last).then((value) {
      print(value);
      _isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Upload Video'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                        child: OutlineButton(
                            onPressed: () =>
                                _fileName != null ? null : _openFileExplorer(),
                            child: Text(_fileName != null
                                ? _getFileInfo()[0]
                                : 'Select the Video File'),
                            borderSide: BorderSide(color: Colors.blue),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0))),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      _paths != null && _paths.isNotEmpty
                          ? !_isUploading
                              ? IconButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () => uploadFile(_getFileInfo()),
                                  icon: Icon(Icons.upload_outlined),
                                )
                              : CircularProgressIndicator()
                          : SizedBox.shrink()
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
