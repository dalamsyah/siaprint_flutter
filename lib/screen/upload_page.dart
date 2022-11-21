import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:iconsax/iconsax.dart';
import 'package:path/path.dart';
import 'package:siapprint/repository/upload_service.dart';
import 'package:siapprint/screen/basket3_page.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({ Key? key }) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with SingleTickerProviderStateMixin {
  final String _image = 'https://ouch-cdn2.icons8.com/84zU-uvFboh65geJMR5XIHCaNkx-BZ2TahEpE9TpVJM/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvODU5/L2E1MDk1MmUyLTg1/ZTMtNGU3OC1hYzlh/LWU2NDVmMWRiMjY0/OS5wbmc.png';
  late AnimationController loadingController;

  final UploadService _uploadService = UploadService();

  File? _file;
  final List<File> _files = [];
  List<PlatformFile> _platformFiles = [];

  bool _isLoading = false;

  selectFile() async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf', 'doc', 'docx']
    );

    if (file != null) {
      setState(() {
        _file = File(file.files.single.path!);
        _platformFiles.add( file.files.first );
        _files.add(_file!);
      });
    }

    loadingController.forward();
  }

  @override
  void initState() {

    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() { setState(() {}); });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50,),
            Image.network(_image, width: 150,),
            const SizedBox(height: 50,),
            Text('Upload your file', style: TextStyle(fontSize: 25, color: Colors.grey.shade800, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            Text('File should be jpg, png, pdf', style: TextStyle(fontSize: 15, color: Colors.grey.shade500),),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: selectFile,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    dashPattern: const [10, 4],
                    strokeCap: StrokeCap.round,
                    color: Colors.blue.shade400,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade50.withOpacity(.3),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.folder_open, color: Colors.blue, size: 40,),
                          const SizedBox(height: 15,),
                          Text('Select your file', style: TextStyle(fontSize: 15, color: Colors.grey.shade400),),
                        ],
                      ),
                    ),
                  )
              ),
            ),
            _platformFiles.isNotEmpty
                ? Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Selected File',
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 15, ),),
                    const SizedBox(height: 10,),

                    Column(
                      children: List.generate(_files.length, (index)  {
                        return Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade200,
                                        offset: const Offset(0, 1),
                                        blurRadius: 3,
                                        spreadRadius: 2,
                                      )
                                    ]
                                ),
                                child: Row(
                                  children: [
                                    // ClipRRect(
                                    //     borderRadius: BorderRadius.circular(8),
                                    //     child: Image.file(_file!, width: 70,)
                                    // ),
                                    const SizedBox(width: 10,),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(basename(_files[index].path),
                                                style: const TextStyle(fontSize: 13, color: Colors.black),),
                                              const SizedBox(height: 5,),
                                              Text('${(_platformFiles[index].size / 1024).ceil()} KB',
                                                style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                                              ),
                                              const SizedBox(height: 5,),
                                              /*Container(
                                              height: 5,
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.blue.shade50,
                                              ),
                                              child: LinearProgressIndicator(
                                                value: loadingController.value,
                                              )
                                          ),*/
                                            ],
                                          )),
                                          IconButton(onPressed: (){
                                            setState((){
                                              // _platformFiles.add( file.files.first );

                                              _files.remove(_files[index]);
                                            });
                                          }, icon: const Icon(Icons.highlight_remove_outlined))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                  ],
                                )
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      }),
                    ),


                    const SizedBox(height: 20,),

                    _isLoading ? const Center(
                      child: CircularProgressIndicator(),
                    ) :

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: const BorderSide(color: Colors.transparent)
                                )
                            )
                        ),
                        child: const Text('Upload'),
                        onPressed: () {

                          setState((){
                            _isLoading = true;
                          });

                          _uploadService.uploadFile(_files).then((value){

                            setState((){
                              _isLoading = false;
                            });

                            final data = jsonDecode(value);

                            if (data['status'] == 0) {

                              _files.clear();
                              _platformFiles = [];

                              Navigator.of(context).pushNamed(Basket3Page.tag);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(data['message']),
                              ));
                            }

                          }).onError((error, stackTrace) {
                            setState((){
                              _isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(error.toString()),
                            ));
                          });
                        },
                      ),
                    )
                  ],
                ))
                : Container(),
            const SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}