import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

import 'flutter_video_icons.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                    child: LayoutBuilder(
                      builder: (_, constraints) => GestureDetector(
                        onTap: () => _openFileExplorer(),
                        child: Container(
                          height: constraints.biggest.width,
                          width: constraints.biggest.width,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(
                                constraints.biggest.width * 0.05),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.video_collection,
                              size: constraints.biggest.width,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Builder(
                    builder: (BuildContext context) => _loadingPath
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: const CircularProgressIndicator(),
                          )
                        : _directoryPath != null
                            ? ListTile(
                                title: const Text('Directory path'),
                                subtitle: Text(_directoryPath),
                              )
                            : _paths != null
                                ? Container(
                                    padding:
                                        const EdgeInsets.only(bottom: 30.0),
                                    height: MediaQuery.of(context).size.height *
                                        0.50,
                                    child: Scrollbar(
                                      child: ListView.separated(
                                        itemCount:
                                            _paths != null && _paths.isNotEmpty
                                                ? _paths.length
                                                : 1,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final bool isMultiPath =
                                              _paths != null &&
                                                  _paths.isNotEmpty;
                                          final String name = 'File $index: ' +
                                              (isMultiPath
                                                  ? _paths
                                                      .map((e) => e.name)
                                                      .toList()[index]
                                                  : _fileName ?? '...');
                                          final path = _paths
                                              .map((e) => e.path)
                                              .toList()[index]
                                              .toString();

                                          return ListTile(
                                            title: Text(
                                              name,
                                            ),
                                            subtitle: Text(path),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                const Divider(),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                    child: ElevatedButton(
                      onPressed: () => _openFileExplorer(),
                      child: Text('Select the files'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
